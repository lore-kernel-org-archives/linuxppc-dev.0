Date: Wed, 31 Dec 2003 13:55:18 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Andreas Schwab <schwab@suse.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.6.0-ben3: Badness in redraw_screen
In-Reply-To: <m3wu8dp6bk.fsf@whitebox.m5r.de>
Message-ID: <Pine.LNX.4.44.0312311338370.22332-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I'm getting this badness in redraw_screen when my iBook wakes up with
> 2.6.0-ben3:
>
> Badness in redraw_screen at drivers/char/vt.c:596
> Call trace:
>  [c000bd50] dump_stack+0x18/0x28
>  [c0008c44] check_bug_trap+0x84/0xac
>  [c0008d34] ProgramCheckException+0xc8/0x180
>  [c00082cc] ret_from_except_full+0x0/0x4c
>  [c015a94c] redraw_screen+0x2c/0x1e0
>  [c00376b4] pm_restore_console+0x38/0x48
>  [c039ef14] 0xc039ef14
>  [c039f468] 0xc039f468
>  [c039fdc8] 0xc039fdc8
>  [c00701d0] sys_ioctl+0x278/0x2f4
>  [c0007d0c] ret_from_syscall+0x0/0x4c
>

Similar badness can be had in set_origin (vt.c:568) and set_palette
(vt.c:2851), on my Lombard. That's called from pm_prepare_console, for a
change.

> (The three unnamed frames are inside pmac_wakeup_devices,
> powerbook_sleep_Core99 and pmu_ioctl).  Does pm_restore_console need
> to acquire the console lock, or is that the duty of the callers?

None of the other callers does this so I'd guess it needs to be done in
pm_restore_console (and pm_prepare_console).

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
