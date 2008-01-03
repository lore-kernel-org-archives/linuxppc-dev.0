Return-Path: <jsamch@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.179])
	by ozlabs.org (Postfix) with ESMTP id CC200DDE20
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Jan 2008 14:33:00 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id z59so1688115pyg.27
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 02 Jan 2008 19:32:59 -0800 (PST)
Message-ID: <169c03cb0801021932s6671526dve15d1948da52ae30@mail.gmail.com>
Date: Wed, 2 Jan 2008 22:32:58 -0500
From: "Jean-Samuel Chenard" <jsamch@macs.ece.mcgill.ca>
Sender: jsamch@gmail.com
To: linuxppc-embedded@ozlabs.org, kernelppc@gmail.com
Subject: RE: File system problem
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Date: Wed, 2 Jan 2008 19:50:13 +0100
> From: "mojtaba"
> I am trying to boot a root file system build by buildroot. But I got this
> error" init has generated signal 11 but has no handler for it".
>
> My kernel version is 2.6.24-rc3
> My target system is PPC 405 (XILINX VIRTEX II pro) I am using the 26-12-2=
007
> snapshot of buildroot.
[ ... ]
> Warning: unable to open an initial console.
> init has generated signal 11 but has no handler for it Kernel panic - not

Hi Mojtaba,

I got a similar error on my ML-310 when I tried a new root filesystem.
 As far as I recall, I needed to make sure that two entries existed in
/dev, namely:

crw-------    1 root     root       5,   1 Jan  1 05:18 console
crw-rw----    1 root     root       1,   3 Dec 10  2007 null

I think that you are missing /dev/console and then init cannot run
since it has nowhere to put its standard output.

You can make those by mounting your CF card on your development host
and (as root) make the nodes:

# mknod -m 660 /dev/console c 5 1
# mknod -m 660 /dev/null c 1 3

In my case, I use the UartLite (ttyUL0) serial port driver, but I'm
pretty sure this is going to fix the problem you are observing.

Regards,

Jean-Samuel
--=20
Ph.D. candidate
Integrated Microsystems Laboratory
McGill University, Montr=E9al, QC, CANADA
Web Page: http://chaos.ece.mcgill.ca
