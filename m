Return-Path: <Clive.Jenkins@xerox.com>
Received: from wvmler4.mail.xerox.com (wvmler4.mail.xerox.com [13.8.138.219])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wvmler4.mail.xerox.com",
	Issuer "wvmler4.mail.xerox.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4400B67B31
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 03:51:41 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Intercept System call using Kernel  module is 2.6 kernel
Date: Tue, 6 Jun 2006 18:14:19 +0100
Message-ID: <35786B99AB3FDC45A821572461791973AC873D@gbrwgceumf01.eu.xerox.net>
From: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
To: "Meswani, Mitesh" <mmeswani@utep.edu>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>        x=3Dmitesh_func();=20
>        printf("mitesh_func returned %d\n",x);

The first thing would be to change your user-space program
to print the error number from errno after your "system call".

        x=3Dmitesh_func();=20
        printf("mitesh_func returned %d, errno=3D%d\n",x,errno);

Or you can use perror() -- look it up.

Clive
 =20


4) I verify from the system logs that when I insmod the kernel module I
get all the print statements. I verified from the logs  that the address
of the sys_call_table is correctly passed and from /proc/kallsysms I can
see that my function mitesh_func has been defined and has the address as
indicated in the logs.=20

The problem is that when I execute my user app I expect to see two
things:=20
 a) I should see a message in the log "Executing mitesh_func..." and=20
 b) A return value of 2=20

However I get an error value -1 returned.=20

Any help and ideas are highly appreciated. =20

Thank you in advance,=20
Mitesh=20
