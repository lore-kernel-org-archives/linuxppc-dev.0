Return-Path: <halesh.sadashiv@ap.sony.com>
Received: from WA4EHSOBE002.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16]) by ozlabs.org (Postfix) with ESMTP id 9FEBBDDE0A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Sep 2008 14:50:33 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: Regarding select() on PPC
Date: Tue, 23 Sep 2008 10:20:00 +0530
Message-ID: <7B7EF7F090B9804A830ACC82F2CDE95D56E135@insardxms01.ap.sony.com>
From: "Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>
To: <benh@kernel.crashing.org>, "Josh Boyer" <jwboyer@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,

The below testcase requires to exit with setting errno as EINVAL, as per
the man page.

I tested this on ARM, I686, PPC64 it was fine, for the same on PPC32 it
used exit with errno set as EFAULT.

On further investigation found there was some long obsolete code in
arch/powerpc/kernel/syscalls.c (function ppc_select()), which was
written in 2.2.0 kernel for PPC32 specific , which resulted in EFAULT.

This needs to be verified, I have proposed patch for PPC32, Please check
the link
http://article.gmane.org/gmane.linux.kernel/735922


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
    if ( errno =3D=3D EINVAL)
      printf("OK\n");
    else
      printf("Not OK, Got errno %d\n", errno);
  }
  exit(0);
}


Thanks,
Halesh



>-----Original Message-----
>From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]
>Sent: Tuesday, September 23, 2008 10:12 AM
>To: Josh Boyer
>Cc: Sadashiiv, Halesh; linuxppc-embedded@ozlabs.org
>Subject: Re: Regarding select() on PPC
>
>On Mon, 2008-09-22 at 11:24 -0400, Josh Boyer wrote:
>> On Mon, Sep 22, 2008 at 08:45:52PM +0530, Sadashiiv, Halesh wrote:
>> >
>> >
>> >The issue is found only in PPC32.
>> >
>> >Please let me if the patch is applicable.
>>
>> Well, no not really.  Mostly because of procedural issues than
anything
>> else.  Read Documentation/SubmittingPatches in the kernel directory.
>>
>> Also, there is a comment above this function that eludes to some
issues
>> with select on ppc32.  You might want to ask the overall PowerPC
>maintainer
>> if that issue still exits.
>
>I have only half of this thread, what is the problem ?
>
>Ben.
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
