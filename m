In-Reply-To: <Pine.LNX.4.44.0312311512580.23214-100000@opal.biophys.uni-duesseldorf.de>
References: <Pine.LNX.4.44.0312311512580.23214-100000@opal.biophys.uni-duesseldorf.de>
Mime-Version: 1.0 (Apple Message framework v609)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <397B64FE-3BA7-11D8-969D-0003938E434C@sympatico.ca>
Cc: debian-powerpc@lists.debian.org,
	<linuxppc-dev@lists.linuxppc.org>, Andreas Schwab <schwab@suse.de>
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
Subject: Re: 2.6.0-ben3: Badness in redraw_screen
Date: Wed, 31 Dec 2003 10:37:21 -0500
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

In the first hunk of your patch you can possibly grab the semaphore and
then do a return 1 with the semaphore held.

If you really need to hold the semaphore to do a vc_allocate then you
should remember to release that semaphore before doing the return 1

So something along the lines of ...

acquire_console_sem();
if (vc_allocate(SUSPEND_CONSOLE)) {
    release_console_sme();
    return 1;
}

would be better I think if you really do need to hold the console_sem()
before calling vc_allocate.

Kevin



On Dec 31, 2003, at 9:15 AM, Michael Schmitz wrote:

> [CC to debian-powerpc as this was reported there as well ...]
>
>>> I'm getting this badness in redraw_screen when my iBook wakes up with
>>> 2.6.0-ben3:
>>>
>>> Badness in redraw_screen at drivers/char/vt.c:596
>>> Call trace:
>>>  [c000bd50] dump_stack+0x18/0x28
>>>  [c0008c44] check_bug_trap+0x84/0xac
>>>  [c0008d34] ProgramCheckException+0xc8/0x180
>>>  [c00082cc] ret_from_except_full+0x0/0x4c
>>>  [c015a94c] redraw_screen+0x2c/0x1e0
>>>  [c00376b4] pm_restore_console+0x38/0x48
>>>  [c039ef14] 0xc039ef14
>>>  [c039f468] 0xc039f468
>>>  [c039fdc8] 0xc039fdc8
>>>  [c00701d0] sys_ioctl+0x278/0x2f4
>>>  [c0007d0c] ret_from_syscall+0x0/0x4c
>>>
>>
>> Similar badness can be had in set_origin (vt.c:568) and set_palette
>> (vt.c:2851), on my Lombard. That's called from pm_prepare_console,
>> for a
>> change.
>>
>>> (The three unnamed frames are inside pmac_wakeup_devices,
>>> powerbook_sleep_Core99 and pmu_ioctl).  Does pm_restore_console need
>>> to acquire the console lock, or is that the duty of the callers?
>>
>> None of the other callers does this so I'd guess it needs to be done
>> in
>> pm_restore_console (and pm_prepare_console).
>
> The following patch works for me... should we submit that to lkml?
>
> 	Michael
>
> --- kernel/power/console.c.org	2003-12-31 14:08:04.000000000 +0100
> +++ kernel/power/console.c	2003-12-31 14:09:26.000000000 +0100
> @@ -20,12 +20,12 @@
>  #ifdef SUSPEND_CONSOLE
>  	orig_fgconsole = fg_console;
>
> +	acquire_console_sem();
>  	if (vc_allocate(SUSPEND_CONSOLE))
>  	  /* we can't have a free VC for now. Too bad,
>  	   * we don't want to mess the screen for now. */
>  		return 1;
>
> -	acquire_console_sem();
>  	set_console(SUSPEND_CONSOLE);
>  	release_console_sem();
>  	if (vt_waitactive(SUSPEND_CONSOLE)) {
> @@ -42,12 +42,14 @@
>  {
>  	console_loglevel = orig_loglevel;
>  #ifdef SUSPEND_CONSOLE
> +	acquire_console_sem();
>  	set_console(orig_fgconsole);
>
>  	/* FIXME:
>  	 * This following part is left over from swsusp. Is it really needed?
>  	 */
>  	update_screen(fg_console);
> +	release_console_sem();
>  #endif
>  	return;
>  }
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
