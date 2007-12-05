Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18261.64094.20273.969051@cargo.ozlabs.ibm.com>
Date: Wed, 5 Dec 2007 12:09:50 +1100
From: Paul Mackerras <paulus@samba.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Merge dtc
In-Reply-To: <1196807633.13978.383.camel@pmac.infradead.org>
References: <20071016050217.GA9052@localhost.localdomain>
	<1196733544.13978.201.camel@pmac.infradead.org>
	<18261.53985.700234.923526@cargo.ozlabs.ibm.com>
	<1196807633.13978.383.camel@pmac.infradead.org>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse writes:

> Make vmlinux the default target instead of zImage would seem like a
> better answer. I'm surprised that it isn't like that already, in fact --
> and I'm only inferring that it isn't from your message. I always thought
> that if I typed 'make' I got the vmlinux and not a zImage.

You're obviously an old-timer. :)  Plain "make" has made the zImage
since at least 2002 in 32-bit and since January 2004 in 64-bit.

The alternative to including dtc is to include compiled versions of
all the .dts files.  The difficulty with that is that .dtb files are
binary blobs which can't be updated with a patch.  The shipped
versions could possibly be shipped as .S versions, or I (and everyone
else who has a tree that I pull from) could have something in my/their
patch-applying scripts that updates the .dtbs if necessary, but in
both cases things could get out of sync for one reason or another
without it being obvious.

In contrast, if the version of dtc in the kernel tree gets out of
date, it will become obvious pretty quickly because compiles will
start failing.  And anyway, the kernel dtc only needs to be recent
enough to compile the .dts files in the kernel tree.

Paul.
