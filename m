Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 4FFD3DDE28
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 04:00:47 +1000 (EST)
Date: Mon, 29 Sep 2008 13:04:55 -0500
From: Olof Johansson <olof@lixom.net>
To: Tirumala Reddy Marri <tmarri@amcc.com>
Subject: Re: Disabling L1 D-cache and side effects
Message-ID: <20080929180455.GA19014@lixom.net>
References: <9323BAFB78DE7C4183466AD03F73EA424D46071D@SDCEXCHANGE01.ad.amcc.com>
	<AC5E1C3367E37D44970B81A6ADD1DA2C060530C1@SDCEXCHANGE01.ad.amcc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AC5E1C3367E37D44970B81A6ADD1DA2C060530C1@SDCEXCHANGE01.ad.amcc.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 29, 2008 at 10:05:41AM -0700, Tirumala Reddy Marri wrote:
>  
> Hi,
>   I had to bring up a PPC based SOC with L1 dcache disabled.  I did that
> and tried to boot Linux using RAMDISK/NFS mount. In RAMDISK I see the
> file system errors. In case of NFS mount I see error saying failed to
> load ld.so library.
>  
>  Could you guys please share thoughts what are the different side
> effects might be causing this.

There are a number of things you have to be careful about when you
disable caches. Depending on your implementation, you likely can't use
lwarx/stwcx, cache ops will not work, etc. Also, are you 100% sure that
this is caused only by disabling L1D, and not by any other problems with
your silicon?

If you're doing early bringup of you'll have a whole lot of debug work
in front of you, and this mailing list is probably not the best place
to bring your homework.


-Olof
