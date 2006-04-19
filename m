Return-Path: <wojciech.kromer@dgt.com.pl>
Received: from dgt.com.pl (mail.dgt.com.pl [195.117.141.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CD2D1679E7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Apr 2006 18:15:05 +1000 (EST)
Message-ID: <4445E9E1.50204@dgt.com.pl>
Date: Wed, 19 Apr 2006 09:42:25 +0200
From: Wojciech Kromer <wojciech.kromer@dgt.com.pl>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: Upgrading cramfs root file system
References: <200604062238.17972.antonio.dibacco@aruba.it>
In-Reply-To: <200604062238.17972.antonio.dibacco@aruba.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dnia 2006-04-06 22:38, Użytkownik Antonio Di Bacco napisał:
> Hi,
>
> how could I upgrade my cramfs rootfs? I have a CGI in the rootfs that receives 
> the new rootfs from a web interface and then tries to write it in the flash. 
> While overwriting the old cramfs, the CGI will continue to work? something 
> weird could happen?
>   

Generally it's not a good idea to override working filesystem ( I've 
tried to do it once).

You can have two separate copies of filesystem, one to work with, and 
another to overwrite, it requires more flash.
Another way is working in initrd, it requires more RAM.
You can also use jffs2 or jffs3 (experimental) to have read-write 
filesystem, and change applications only, not whole filesystem (be 
carefull with changing busybox or libraries!)
