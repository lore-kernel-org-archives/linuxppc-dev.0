Return-Path: <GARCIAJ@3il.fr>
Received: from email.3il.fr (email.3il.fr [195.25.243.230])
	by ozlabs.org (Postfix) with ESMTP id 4B66067B63
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2005 02:19:46 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 15 Jun 2005 18:19:43 +0200
Message-ID: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B35@exnet.3il.fr>
From: =?iso-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
To: <linuxppc-dev@ozlabs.org>
Subject: Error while opennig device file
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi everybody,
I'd like to have your opinion on such a stupid question. Indeed, it must =
be very easy to see but
I can't find out what goes on.
I'm writing a device driver. In the init_module(), I register it with =
TEST_DEV_MAJOR =3D 122=20

ret_val =3D register_chrdev(TEST_DEV_MAJOR, TEST_DEV_PROC_NAME, =
&lcd_fops);

In the user space, I have a programm that creates two device files using =
the same major number but with=20
different minor numbers:

ret_val =3D system("mknod -m 777 /dev/Test1 c 122 1");
ret_val =3D system("mknod -m 777 /dev/Test1 c 122 2");

Then I try to open both files :
file_desc1 =3D open("/dev/test1", O_RDWR);
file_desc2 =3D open("/dev/test2", O_RDWR);

Unfortunately, I go through an error on the second open. It seems that I =
can't get those 2 files opened
at the same time. I'm a newbie in linux kernel development, so could you =
explain me why?
What I want to do is to have 2 device files that use the same driver =
module. In my module, I test the minor number
and handle an array of 2 structures (1 for each minor number).
For example, it could represent 2 communication channels ; I could have =
1 device file by channel on which I
could do read/write operation. My module will write/read in array[0] for =
channel 0 and in array[1] for channel 1.

Tks a lot and sorry for such a question but nobody can help me there and =
I can't find out browsing forums and books...
