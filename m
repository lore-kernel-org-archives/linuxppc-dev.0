Return-Path: <walsh.benj@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.228])
	by ozlabs.org (Postfix) with ESMTP id 48152DE034
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jan 2009 07:59:48 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so5104051rvb.9
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jan 2009 12:59:47 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 23 Jan 2009 15:59:47 -0500
Message-ID: <cb298a870901231259h6bd1ae2ag2baeb20173219664@mail.gmail.com>
Subject: Maple PPC970 kexec crash-dump problems
From: Benjamin Walsh <walsh.benj@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=000e0cd22cd849918004612cab6c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--000e0cd22cd849918004612cab6c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi all,

I am trying to use kexec with a crash dump kernel on a Maple board (Motorola
ATCA6101 to be precise). This board is running a two-CPU PPC970FX. I am
running a 2.6.27-10 kernel and have tried both older kexec-tools and the
newest ones. I have tried SMP and non-SMP kernels.

Using kexec -l to fast boot works correctly. However, loading a crash dump
kernel and triggering a crash via echo c > /proc/sysrq-trigger simply hangs
the board. I have traced the sequence down to after the call to
kexec_copy_flush(), when the CPU returns to real-address mode (bl
real_mode). At this point I have no further debugging information.

Two things could help me:

- Getting the fix if this is a known issue and a fix exists. I have looked
at recent patches and nothing lept to mind, mostly relocatable kernel
support.
- Obtaining the address of the serial port @3f8 in real mode. The init
sequence with udbg ON says that the physical address of the port is
0xf40003f8; however, setting it up in poll mode and trying to stuff
characters in the tx buffer doesn't produce anything.

Has anyone recently tried to use the serial port in real mode ?

Thanks for any help.

Ben

--000e0cd22cd849918004612cab6c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,<br><br>I am trying to use kexec with a crash dump kernel on a Maple=
 board (Motorola ATCA6101 to be precise). This board is running a two-CPU P=
PC970FX. I am running a 2.6.27-10 kernel and have tried both older kexec-to=
ols and the newest ones. I have tried SMP and non-SMP kernels.<br>
<br>Using kexec -l to fast boot works correctly. However, loading a crash d=
ump kernel and triggering a crash via echo c &gt; /proc/sysrq-trigger simpl=
y hangs the board. I have traced the sequence down to after the call to kex=
ec_copy_flush(), when the CPU returns to real-address mode (bl real_mode). =
At this point I have no further debugging information.<br>
<br>Two things could help me:<br><br>- Getting the fix if this is a known i=
ssue and a fix exists. I have looked at recent patches and nothing lept to =
mind, mostly relocatable kernel support.<br>- Obtaining the address of the =
serial port @3f8 in real mode. The init sequence with udbg ON says that the=
 physical address of the port is 0xf40003f8; however, setting it up in poll=
 mode and trying to stuff characters in the tx buffer doesn&#39;t produce a=
nything.<br>
<br>Has anyone recently tried to use the serial port in real mode ?<br><br>=
Thanks for any help.<br><br>Ben<br><br>

--000e0cd22cd849918004612cab6c--
