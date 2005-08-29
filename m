Return-Path: <grave@ipno.in2p3.fr>
Received: from ipnmail.in2p3.fr (ipnmail.in2p3.fr [134.158.92.208])
	by ozlabs.org (Postfix) with ESMTP id C512B6816D
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Aug 2005 20:03:30 +1000 (EST)
Received: from ipnnarval.in2p3.fr (ipnnarval.in2p3.fr [134.158.92.7])
	by ipnmail.in2p3.fr (8.13.4/8.13.4/IN2P3.FR) with ESMTP id
	j7T9XAac032414
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Aug 2005 11:33:10 +0200
From: Xavier Grave <grave@ipno.in2p3.fr>
To: ppc dev <linuxppc-dev@ozlabs.org>
Content-Type: multipart/mixed; boundary="=-cNTu8T9z9vpLf97E8Ft6"
Date: Mon, 29 Aug 2005 11:32:48 +0200
Message-Id: <1125307968.5440.15.camel@ipnnarval>
Mime-Version: 1.0
Subject: [Fwd: Re: Allocating a cache-safe buffer for DMA devices and
	drivers]
Reply-To: grave@ipno.in2p3.fr
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-cNTu8T9z9vpLf97E8Ft6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Sorry, forgot to cc...

--=-cNTu8T9z9vpLf97E8Ft6
Content-Disposition: inline
Content-Description: Message =?ISO-8859-1?Q?transf=E9r=E9?= - Re:
	Allocating a cache-safe buffer for DMA devices and drivers
Content-Type: message/rfc822

Subject: Re: Allocating a cache-safe buffer for DMA devices and drivers
From: Xavier Grave <grave@ipno.in2p3.fr>
Reply-To: grave@ipno.in2p3.fr
To: Garcia =?ISO-8859-1?Q?J=E9r=E9mie?= <GARCIAJ@3il.fr>
In-Reply-To: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B4D@exnet.3il.fr>
References: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B4D@exnet.3il.fr>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1125307903.5440.13.camel@ipnnarval>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Date: Mon, 29 Aug 2005 11:31:48 +0200
Content-Transfer-Encoding: 8bit

Hi,

Something like that maybe :

 virtual_ad = (unsigned long *) kmalloc(sizeof(long)*taille_dma,
                                         GFP_KERNEL|GFP_DMA|GFP_ATOMIC);

O+ xavier

Le lundi 29 août 2005 à 11:16 +0200, Garcia Jérémie a écrit :
> Hi everybody, I have to port a vxWorks appz to Linux Montavista running on a powerPC 405EP based architecture.
> In this one, we use the following vxWorks system call: cacheDmaMalloc( ) whose man page is :
> 
> NAME
>     cacheDmaMalloc( ) - allocate a cache-safe buffer for DMA devices and drivers
> 
> SYNOPSIS
> void * cacheDmaMalloc
>     (
>     size_t bytes              /* number of bytes to allocate */
>     )
> 
> DESCRIPTION
>     This routine returns a pointer to a section of memory that will not experience any cache coherency problems. Function pointers in the CACHE_FUNCS structure provide access to DMA support routines.
> 
> RETURNS
>     A pointer to the cache-safe buffer, or NULL. 
> 
> 
> I need to handle the given amount of memory from the user space. 
> So could anyone told how to achieve the same goal on Linux with these constraints?
> 
> Tks a lot for your precious help!
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

--=-cNTu8T9z9vpLf97E8Ft6--
