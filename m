Date: Mon, 11 Jan 1999 23:44:31 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: Corey Minyard <minyard@acm.org>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: arch/ppc/kernel restructure + MVME/MTX OpenPIC support
In-Reply-To: <m267advdk2.fsf@wf-rch.cirr.com>
Message-ID: <Pine.LNX.4.04.9901112254370.926-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



I have just made the changes you suggested, along with updating a couple
of files (irq.c, setup.c) to match the versions in 2.2.0-pre6. (thanks to 
keys@brio.yikes.com for pointing this out)

There is also an additional patch to linux/mm/vmscan.c provided by Ryan
Nielsen which has been included which allowed me to boot an SMP kernel
again.

The patch is at
ftp://ftp.microux.com/pub/linux/linuxppc-rework-troy-2.patch.gz
 
> Also, a couple of small things that probably need to be fixed:
> 
>  * The __initfunc()  needs to be removed from all the xxx_setup_residual
>    function calls, since that is called all the time.
> 
Heh, this was causing 'cat /proc/cpuinfo' to crash the kernel

>  * The patch to idle.c needs to look something like:
> 
> --- linux-2.2p4.orig/arch/ppc/kernel/idle.c     Mon Jan  4 16:59:13 1999
> +++ linux-2.2p4/arch/ppc/kernel/idle.c  Mon Jan  4 16:49:13 1999
> @@ -301,7 +301,14 @@
>                         hid0 &= ~(HID0_NAP | HID0_SLEEP | HID0_DOZE);
>                         hid0 |= (powersave_nap? HID0_NAP: HID0_DOZE) | HID0_DPM;
>                         asm("mtspr 1008,%0" : : "r" (hid0));
> -                       msr |= MSR_POW;
> +
> +                       /* set the POW bit in the MSR, and enable interrupts
> +                          so we'll wake up sometime! */
> +                       _nmask_and_or_msr(0, MSR_POW | MSR_EE);
> +
> +                       /* Disable interrupts again so restore_flags will
> +                          work. */
> +                       _nmask_and_or_msr(MSR_EE, 0);
>                 }
>                 restore_flags(msr);
>         default:
> 
> 
> -- 
> Corey Minyard               Internet:  minyard@acm.org
>   Work: minyard@nortel.ca       UUCP:  minyard@wf-rch.cirr.com
> 
> 

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
