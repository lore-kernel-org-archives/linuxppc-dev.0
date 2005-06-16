Return-Path: <GARCIAJ@3il.fr>
Received: from email.3il.fr (email.3il.fr [195.25.243.230])
	by ozlabs.org (Postfix) with ESMTP id 8A2AD67A6F
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2005 18:37:01 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 16 Jun 2005 10:35:13 +0200
Message-ID: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B38@exnet.3il.fr>
From: =?iso-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
To: "Dustin Lang" <dalang@cs.ubc.ca>,
	"Eugene Surovegin" <ebs@ebshome.net>
Cc: linuxppc-dev@ozlabs.org
Subject: RE : RE : Error while opennig device file
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi everybody! I'm gonna give you all the info you asked me:

[Dustin]
>> does it work from the command line?  Do both mknod commands work?
--> Yes both mknod seem to work from the command line since they are =
both created
    root@10.16.9.232:~# mknod -m 777 /dev/test1 c 122 1
    root@10.16.9.232:~# mknod -m 777 /dev/test2 c 122 2           =20
That looks good

>> When you "ls -l /dev/test{1,2}" , what do you get?=20
--> root@10.16.9.232:~# ls -l /dev/test{1,2}
    crwxrwxrwx    1 root     root     122,   1 Jun 16  2005 /dev/test1
    crwxrwxrwx    1 root     root     122,   2 Jun 16  2005 /dev/test2
That looks good

>> What happens when you "cat /dev/test1" ?
--> root@10.16.9.232:~# cat /dev/test1
    cat: /dev/test1: No such device
That is ok, isn't it?

>> What happens when you "echo > /dev/test1" ?   =20
--> root@10.16.9.232:~# echo > /dev/test1
    bash: /dev/test1: No such device
That is ok, isn't it?

[Eugene]
>> How does open routine for your device look like?
-->
static int test_open(struct inode *inode , struct file *file)
{
  int ret_val =3D 0;
 =20
  if (Device_open !=3D 0)
    return -EBUSY;
 =20
  Device_open++;
  printk("%d minor number!\n",MINOR(inode->i_rdev)); =20
  MOD_INC_USE_COUNT;

  return ret_val;
}

Very traditionnal...

>> What error do you get on second open?
--> I trace the execution of my programm and get the following :
First opened succeeded, open() return code : 3    =20
Can't open second file, open() return code : -1 , errno =3D 16

Looking in the errno.h, we have :
#define	EBUSY		16	/* Device or resource busy */


If tou need more tell me.
Tks again for your help guys!


-------- Message d'origine--------
De: Dustin Lang [mailto:dalang@cs.ubc.ca]
Date: mer. 15/06/2005 20:16
=C0: Eugene Surovegin
Cc: Garcia J=E9r=E9mie; linuxppc-dev@ozlabs.org
Objet : Re: RE : Error while opennig device file
=20

Also - does it work from the command line?  Do both mknod commands work? =

When you "ls -l /dev/test{1,2}" , what do you get?  What happens when =
you=20
"cat /dev/test1" or "echo > /dev/test1" ?

Cheers,
dstn.


>> I'm sorry but this is a "copy to mail" error.
>> Here is the right code:
>>
>> ret_val =3D system("mknod -m 777 /dev/test1 c 122 1");
>> ret_val =3D system("mknod -m 777 /dev/test2 c 122 2");
>>
>> file_desc1 =3D open("/dev/test1", O_RDWR);
>> file_desc2 =3D open("/dev/test2", O_RDWR);
