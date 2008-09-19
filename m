Return-Path: <halesh.sadashiv@ap.sony.com>
Received: from IE1EHSOBE002.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16]) by ozlabs.org (Postfix) with ESMTP id 628C4DDF70
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Sep 2008 21:50:54 +1000 (EST)
Received: from mail25-dub (localhost.localdomain [127.0.0.1])	by
	mail25-dub-R.bigfish.com (Postfix) with ESMTP id EDDE9167815F	for
	<linuxppc-embedded@ozlabs.org>; Fri, 19 Sep 2008 11:50:47 +0000 (UTC)
Received: from sggdcex1ns01.sony.com.sg (sggdcex1ns01.sony.com.sg
	[121.100.32.134])	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA
	(168/168
	bits))	(No client certificate requested)	by mail25-dub.bigfish.com
	(Postfix)
	with ESMTP id F23B9A20055	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Sep 2008 11:50:46 +0000 (UTC)
Received: from sggdcwn1vs01.sony.com.sg (sggdcwn1vs01 [43.68.8.23])	by
	sggdcex1ns01.sony.com.sg (8.13.7+Sun/8.13.7) with SMTP id
	m8JBoc24001102	for
	<linuxppc-embedded@ozlabs.org>; Fri, 19 Sep 2008 19:50:41 +0800 (SGT)
Received: from sgapxbh04.ap.sony.com ([43.68.15.49])	by
	sgsesgdcid01.sony.com.sg (8.13.7+Sun/8.13.7) with ESMTP id
	m8JBocvj018895	for
	<linuxppc-embedded@ozlabs.org>; Fri, 19 Sep 2008 19:50:38 +0800 (SGT)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: Regarding select() on PPC
Date: Fri, 19 Sep 2008 17:20:31 +0530
Message-ID: <7B7EF7F090B9804A830ACC82F2CDE95D56DCA7@insardxms01.ap.sony.com>
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


Hi all,

Please find the below testcase.

#include <stdio.h>
#include <sys/time.h>
#include <sys/types.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <time.h>
#include <errno.h>
#include <stdlib.h>

int main()
{

 int fd;
 fd_set rfds;
 struct timeval tv;
 int ret_val;

 if ((fd =3D open("test_file", O_RDWR|O_CREAT, 0664)) < 0)
  {
    printf("Open failed\n");
  }

  FD_ZERO(&rfds);
  FD_SET(fd, &rfds);

  /* Wait up to five seconds. */
  tv.tv_sec =3D 1;
  tv.tv_usec =3D 0;

  if ( (ret_val =3D select(-1, &rfds, NULL, NULL, &tv)) < 0)
  {
    if ( ret_val =3D=3D EINVAL)
      printf("OK\n");
    else
      printf("Not OK, Got errno %d\n", errno);
  }
  exit(0);
}


For negetive value of n (first argument to select) select fails with
EINVAL error,

But for the same when I tested for PowerPC it was giving EFAULT,=20
Its on 2.6.16 kernel.

Please let me know, If this is fixed or it's a issue in PPC.
For other archs its working fine.


Thanks,
Halesh






-------------------------------------------------------------------
This email is confidential and intended only for the use of the =
individual or entity named above and may contain information that is =
privileged. If you are not the intended recipient, you are notified that =
any dissemination, distribution or copying of this email is strictly =
prohibited. If you have received this email in error, please notify us =
immediately by return email or telephone and destroy the original =
message. - This mail is sent via Sony Asia Pacific Mail Gateway.
-------------------------------------------------------------------
