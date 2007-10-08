Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from mail172-dub-R.bigfish.com (mail-dub.bigfish.com
	[213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0618CDDF86
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 09:36:48 +1000 (EST)
Message-ID: <470ABEF8.4030508@am.sony.com>
Date: Mon, 08 Oct 2007 16:36:24 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Ranulf Doswell <ralf@ranulf.net>
Subject: Re: [patch 6/6] PS3: Add os-area database routines
References: <20071006213542.311447584@am.sony.com>	
	<20071006213542.954029915@am.sony.com>	
	<18a15270710080648x3b5f1135meea3d7b048a1a543@mail.gmail.com>	
	<470A6E4E.5090009@am.sony.com>
	<18a15270710081559m3236126r85f797718300756f@mail.gmail.com>
In-Reply-To: <18a15270710081559m3236126r85f797718300756f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ranulf Doswell wrote:
> On 08/10/2007, *Geoff Levand* <geoffrey.levand@am.sony.com
> <mailto:geoffrey.levand@am.sony.com>> wrote:
> 
>     > How do we go about claiming one of these OS_AREA_DB_OWNER_ keys? I'd
>     > very much like to use this functionality in my python-ps3 games
>     library.
> 
>     It sounds like you should be storing your info in the file system like
>     all other applications do.
> 
> 
> I'd agree that for large amounts of application specific data, the
> filesystem is the correct approach.
> 
> However, in this case the only data required is a single identifier used
> to identify one PS3 from another, and in fact this single 64-bit token
> can be shared amongst many other applications that require the same
> function - certainly I intend to expose it in a common way in my games
> library's API for all users of the library.
> 
> In my particular case, my bootable CD image does not have any other use
> for a filesystem on disk beyond the initrd image on the CD-ROM; this is
> important because some PS3s may be formatted as 100% GameOS. All that is
> needed is to write the standard kboot image to flash so that it is able
> to bootstrap the CD image.
> 
> As the PS3 has flash available and you are adding a mechanism for
> storing very small bits of data in the flash, it seems silly not to use
> it and attempt instead to write my own incompatible database format to
> store this in the flash memory. Your database also has the added
> protection of not being overwritten when the loader is re-flashed, as it
> is protected by the kernel.
> 
> If you agree in principle that one of these identifiers can be allocated
> to this purpose, I'm happy to write and submit a patch that exposes the
> get/set system ID functionality to userland, whilst internally using
> your database. This could also allow for some of the bits to be used as
> check bits to ensure data validity.


This feature is not intended for general application use.  If the user
wants to store data, then they should setup the system with a writable
filesystem.

-Geoff
