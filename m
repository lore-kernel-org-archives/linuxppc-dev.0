Mime-Version: 1.0
Message-Id: <p04330101b7f89a7f640b@[24.163.33.28]>
In-Reply-To: <15314.48871.176187.508759@cargo.ozlabs.ibm.com>
References: <p04330100b7f7f805ef9a@[24.163.33.28]>
 <15314.48871.176187.508759@cargo.ozlabs.ibm.com>
Date: Sun, 21 Oct 2001 11:48:13 -0400
To: paulus@samba.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: Re: 2.4.13-pre5 crash when mounting proc
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  > 6500, Linux/PPC 2KQ4 running 2.2.19, I compiled 2.4.13-pre5, rsynced
>>  from bk yesterday.
>
>linuxppc_2_4 or linuxppc_2_4_devel?

linuxppc_2_4, and to be more specific I rsynced from
source.mvista.com, which I understand is the bk mirror.


>  > On boot, when it gets to "mounting proc
>>  filesystem," I get a break into the mon debugger, but I have no
>>  keyboard response (so no backtrace). The info I can copy is:
>
>You have an ADB keyboard, no?  I am surprised the keyboard doesn't
>respond.

Yes, on both the 6500 and the 9500. On the 6500, where I have long
been having stability problems with 2.4 that are completely unrelated
to this crash, the keyboard uniformly has never responded in mon. I
tried to hack mon to automatically print a backtrace but could never
get that to work either. On the 9500, I only assumed it broke into
mon. What happened (besides the total lockup) was that what looked
like parts of the mon output overwrote the boot information that was
listed above the point of the freeze. IOW, I saw a pc= and other
parts randomly written over the console output up to that point. For
some reason, no numbers came out, so I had even less info than for
the 6500.


>  > vector: 300 at pc = c02432fc lr = c00544e0 msr = b032 sp = c5dc3ef0
>>
>>  plus some more that I'm not sure will help much. For this output
>>  alone, should I include System.map also?
>
>Yes, or alternatively find out where those pc and lr addresses are in
>the System.map list and tell us the nearest symbols and their values.

System.map-2.4.13-pre5 from the 6500:

c0242994 ? __exitcall_netlink_proto_exit
c0242998 ? __exitcall_packet_exit
c024299c A __start___ex_table
c024299c A _edata
c0245b4c ? __ksymtab_rtc_lock
c0245b4c A __start___ksymtab

c00541d8 t do_remount
c00542f0 t do_add_mount
c0054448 t copy_mount_options
c0054560 T do_mount
c005471c T sys_mount
c0054808 t chroot_fs_refs



Thanks for the help, Paul.



Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
