Return-Path: <bouncefilter+linuxppc-embedded=wd=denx.de@lists.linuxppc.org>
Message-ID: <023EF71CB65AA949A2C510353690C86B027FB4@rokonet-e.rokonet.co.il>
From: Eli Brin <eli.brin@rokonet.co.il>
To: "'VanBaren, Gerald (AGRE)'" <Gerald.VanBaren@smiths-aerospace.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Watchdog timer reset
Date: Thu, 12 Aug 2004 14:35:08 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

Thanks for the reply.

I have done the procedure you suggested:
Just before the reset, I can see that the output didn't change for about two
seconds.  This should cause a reset.

I add an output toggle to the wdt_mpc8x.c (from Denx).

The reset occurs after I register to the watchdog timer.

But, strangely, if I don't do any printk() and printf() no resets.

Can the printing to console from kernel/user "block" the kernel for so long?

The only interrupt masking I can see in the spin_lock() in wdt_mpc8xx.c.

I did notice that in our module: If I don't use copy_from_user(), The data
is valid:

static int proc_write_AcmOutputs(struct file *file, const char *page,
unsigned long count, void *data)
{
  int len;
  unsigned long flags;

  struct acmIo_data_t *acmOutputs_data = (struct acmIo_data_t *)data;

  if (count > MESSAGE_LENGTH)
  	len = MESSAGE_LENGTH;
  else
    len  = count;

  if (copy_from_user(acmOutputs_data->Message, page, len))
  {
    return -EFAULT;
  }

  acmOutputs_data->Message[len] = '\0';

  if (parseIo_data(acmOutputs_data->Message))
    return -EFAULT;

  del_timer(&outputs[acmParsed_data.index].timer);

  outputs[acmParsed_data.index].mode = acmParsed_data.mode;
  outputs[acmParsed_data.index].rate = acmParsed_data.rate;

  switch (acmParsed_data.mode)
  {
    case OUTPUT_BLINK:
      outputs[acmParsed_data.index].timer.function = output_blink;
      output_blink(acmParsed_data.index);
      break;

    case OUTPUT_BEEP:
		do_output(acmParsed_data.index, OUTPUT_TOGGLE);

		outputs[acmParsed_data.index].timer.function =
do_beep_timer;

		save_flags(flags);
		cli();

		init_timer(&outputs[acmParsed_data.index].timer);
		outputs[acmParsed_data.index].timer.expires = jiffies +
outputs[acmParsed_data.index].rate;
		add_timer(&outputs[acmParsed_data.index].timer);

		restore_flags(flags);

      break;

    default:
       do_output(acmParsed_data.index, acmParsed_data.mode);
      break;
  }

  return len;
}

I can just do a memcpy from page to my variable in the module.

Where is the MMU support?


Thank you,
Eli Brin


-----Original Message-----
From: VanBaren, Gerald (AGRE) [mailto:Gerald.VanBaren@smiths-aerospace.com]
Sent: Wednesday, August 11, 2004 10:12 PM
To: Eli Brin
Subject: RE: Watchdog timer reset


I suspect you are masking interrupts for extended periods.  If you mask the
interrupts, you aren't going to get timer ticks appropriately and thus won't
kick the WDT properly.  My suggestions are to look at your code (especially
writing to flash) and/or use an output discrete and toggle it every time you
kick the WDT.  Look at the output with a scope and see what it is doing, I
suspect you will find large gaps.

gvb


> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf

> Of Eli Brin
> Sent: Wednesday, August 11, 2004 7:05 AM
> To: 'linuxppc-embedded@lists.linuxppc.org'
> Subject: Watchdog timer reset
>

>

>

> Hello,
>

> We use an mpc8xx custom board, u-boot 1.1.1 and ELDK 3.0

> (kernel 2.4.24 with
> HZ = 500).
>

> My problems are using the wdt_mpc8xx watchdog.  We have a lot

> off resets,
> especially during application loading.
>

> I have tried to increase the reset rate of the module to

> HZ/10 instead of
> HZ/2 but it didn't help.  Sometime creating a new image (we

> use SELF) solves
> the problem. To overcome the resets we insert/remove sleep or
> increase/decrease our logging (printf to console).
>

> The applications are written in C++ with pthreads

> multi-threading optimized
> with -O2.
>

> We use poll-select on the serial channel (SMC2), and all

> blocking functions
> are implemented within threads.
>

> Tried to fork() instead off using system() and other tests,

> but every time
> we think we solved it...after some time the resets come back.
>

> I could not find a rational for the problem.  Any ideas?
>

> Thank you,
> Eli Brin
>

>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
