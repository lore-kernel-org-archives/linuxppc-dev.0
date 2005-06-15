Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B154367B62
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2005 03:26:09 +1000 (EST)
Date: Wed, 15 Jun 2005 10:26:05 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Garcia J?r?mie <GARCIAJ@3il.fr>
Message-ID: <20050615172605.GA21165@gate.ebshome.net>
References: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B35@exnet.3il.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B35@exnet.3il.fr>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Error while opennig device file
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 15, 2005 at 06:19:43PM +0200, Garcia J?r?mie wrote:
> Hi everybody,
> I'd like to have your opinion on such a stupid question. Indeed, it must be very easy to see but
> I can't find out what goes on.
> I'm writing a device driver. In the init_module(), I register it with TEST_DEV_MAJOR = 122 
> 
> ret_val = register_chrdev(TEST_DEV_MAJOR, TEST_DEV_PROC_NAME, &lcd_fops);
> 
> In the user space, I have a programm that creates two device files using the same major number but with 
> different minor numbers:
> 
> ret_val = system("mknod -m 777 /dev/Test1 c 122 1");
> ret_val = system("mknod -m 777 /dev/Test1 c 122 2");
                                          ^ 
> Then I try to open both files :
> file_desc1 = open("/dev/test1", O_RDWR);
> file_desc2 = open("/dev/test2", O_RDWR);

You must be kidding.

You create /dev/Test1 twice, and then open /dev/test1 and /dev/test2.

First of all, Linux fs are case sensitive, second, you don't create 
test2 (even with wrong case).

-- 
Eugene
