Return-Path: <kernelppc@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id C746ADDEBB
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Jan 2008 02:56:46 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so2745737uge.0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 03 Jan 2008 07:56:45 -0800 (PST)
From: "mojtaba" <kernelppc@gmail.com>
To: <linuxppc-embedded@ozlabs.org>
References: <169c03cb0801021932s6671526dve15d1948da52ae30@mail.gmail.com>
In-Reply-To: <169c03cb0801021932s6671526dve15d1948da52ae30@mail.gmail.com>
Subject: RE: File system problem
Date: Thu, 3 Jan 2008 16:57:30 +0100
Message-ID: <004801c84e21$59312760$0b937620$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
Thank you very much for your answers.

But I have both console and null in /dev.

-rw-rw-rw- 1 mojtaba mojtaba    0 2007-12-26 15:50 console
-rw-rw-rw- 1 mojtaba mojtaba    0 2007-12-26 15:50 null

They have been created by buildroot. Do I need to create them manually?
Actually the size of both of them is 0 and both are empty files. Is that =
a
problem?

Thank you in advance and best regards,
Mojtaba

-----Original Message-----
From: jsamch@gmail.com [mailto:jsamch@gmail.com] On Behalf Of =
Jean-Samuel
Chenard
Sent: Thursday, January 03, 2008 4:33 AM
To: linuxppc-embedded@ozlabs.org; kernelppc@gmail.com
Subject: RE: File system problem

> Date: Wed, 2 Jan 2008 19:50:13 +0100
> From: "mojtaba"
> I am trying to boot a root file system build by buildroot. But I got =
this
> error" init has generated signal 11 but has no handler for it".
>
> My kernel version is 2.6.24-rc3
> My target system is PPC 405 (XILINX VIRTEX II pro) I am using the
26-12-2007
> snapshot of buildroot.
[ ... ]
> Warning: unable to open an initial console.
> init has generated signal 11 but has no handler for it Kernel panic - =
not

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
