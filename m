Return-Path: <halesh.sadashiv@ap.sony.com>
Received: from IE1EHSOBE002.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16]) by ozlabs.org (Postfix) with ESMTP id 934D1DDEEF
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Sep 2008 23:30:31 +1000 (EST)
Received: from mail34-dub (localhost.localdomain [127.0.0.1])	by
	mail34-dub-R.bigfish.com (Postfix) with ESMTP id BF4AC4C810E	for
	<linuxppc-embedded@ozlabs.org>; Fri, 19 Sep 2008 13:30:25 +0000 (UTC)
Received: from sggdcex1ns01.sony.com.sg (sggdcex1ns01.sony.com.sg
	[121.100.32.134])	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA
	(168/168
	bits))	(No client certificate requested)	by mail34-dub.bigfish.com
	(Postfix)
	with ESMTP id 50122738071	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Sep 2008 13:30:21 +0000 (UTC)
Received: from sggdcwn1vs01.sony.com.sg (sggdcwn1vs01 [43.68.8.23])	by
	sggdcex1ns01.sony.com.sg (8.13.7+Sun/8.13.7) with SMTP id
	m8JDU9o1007527	for
	<linuxppc-embedded@ozlabs.org>; Fri, 19 Sep 2008 21:30:17 +0800 (SGT)
Received: from sgapxbh04.ap.sony.com ([43.68.15.49])	by
	sgsesgdcid02.sony.com.sg (8.13.7+Sun/8.13.7) with ESMTP id
	m8JDU9Dp015711	for
	<linuxppc-embedded@ozlabs.org>; Fri, 19 Sep 2008 21:30:09 +0800 (SGT)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: RE: Regarding select() on PPC
Date: Fri, 19 Sep 2008 19:00:07 +0530
Message-ID: <7B7EF7F090B9804A830ACC82F2CDE95D56DCC8@insardxms01.ap.sony.com>
From: "Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



>-----Original Message-----
>From: Sadashiiv, Halesh
>Sent: Friday, September 19, 2008 5:21 PM
>To: 'linuxppc-embedded@ozlabs.org'
>Subject: Regarding select() on PPC
>
>
>Hi all,
>
>Please find the below testcase.
>
>#include <stdio.h>
>#include <sys/time.h>
>#include <sys/types.h>
>#include <unistd.h>
>#include <fcntl.h>
>#include <string.h>
>#include <time.h>
>#include <errno.h>
>#include <stdlib.h>
>
>int main()
>{
>
> int fd;
> fd_set rfds;
> struct timeval tv;
> int ret_val;
>
> if ((fd =3D open("test_file", O_RDWR|O_CREAT, 0664)) < 0)
>  {
>    printf("Open failed\n");
>  }
>
>  FD_ZERO(&rfds);
>  FD_SET(fd, &rfds);
>
>  /* Wait up to five seconds. */
>  tv.tv_sec =3D 1;
>  tv.tv_usec =3D 0;
>
>  if ( (ret_val =3D select(-1, &rfds, NULL, NULL, &tv)) < 0)
>  {
>    if ( ret_val =3D=3D EINVAL)
=09
	if ( errno =3D=3D EINVAL)
Need to change it to errno, still not works.

>      printf("OK\n");
>    else
>      printf("Not OK, Got errno %d\n", errno);
>  }
>  exit(0);
>}
>
>
>For negetive value of n (first argument to select) select fails with
EINVAL
>error,
>
>But for the same when I tested for PowerPC it was giving EFAULT,
>Its on 2.6.16 kernel.
>
>Please let me know, If this is fixed or it's a issue in PPC.
>For other archs its working fine.
>
>
>Thanks,
>Halesh
>
>
>



-------------------------------------------------------------------
This email is confidential and intended only for the use of the =
individual or entity named above and may contain information that is =
privileged. If you are not the intended recipient, you are notified that =
any dissemination, distribution or copying of this email is strictly =
prohibited. If you have received this email in error, please notify us =
immediately by return email or telephone and destroy the original =
message. - This mail is sent via Sony Asia Pacific Mail Gateway.
-------------------------------------------------------------------
