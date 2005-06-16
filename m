Return-Path: <marcin.dawidowicz@kontron.pl>
Received: from postoffice.rnd.kontron.pl (unknown [217.153.29.44])
	by ozlabs.org (Postfix) with ESMTP id 73EF2679E7
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2005 19:50:16 +1000 (EST)
From: Marcin Dawidowicz <marcin.dawidowicz@kontron.pl>
To: linuxppc-dev@ozlabs.org
Date: Thu, 16 Jun 2005 11:23:41 +0200
References: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B38@exnet.3il.fr>
In-Reply-To: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B38@exnet.3il.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200506161123.42050.marcin.dawidowicz@kontron.pl>
Cc: Garcia =?iso-8859-1?q?J=E9r=E9mie?= <GARCIAJ@3il.fr>
Subject: Re: Error while opennig device file
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 16 of June 2005 10:35, Garcia J=E9r=E9mie wrote:
> static int test_open(struct inode *inode , struct file *file)
> {
>   int ret_val =3D 0;
>
>   if (Device_open !=3D 0)   <------
>     return -EBUSY;           <------
>
>   Device_open++;          <------
>   printk("%d minor number!\n",MINOR(inode->i_rdev));
>   MOD_INC_USE_COUNT;
>
>   return ret_val;
> }
>
> Very traditionnal...
>
Have a look on marked lines.

>  What error do you get on second open?
> --> I trace the execution of my programm and get the following :
> First opened succeeded, open() return code : 3 =A0 =A0
> Can't open second file, open() return code : -1 , errno =3D 16
>
> Looking in the errno.h, we have :
> #define=A0EBUSY=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A016=A0=A0=A0=A0=A0=A0/* De=
vice or resource busy */

This is what I would expect. You can remove marked lines and try again...

Regards,
Marcin
