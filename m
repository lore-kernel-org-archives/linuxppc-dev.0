Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [RFC,
	PATCH 4/4] Add support to OProfile for profiling Cell BE SPUs --
	update
Date: Sun, 4 Feb 2007 03:52:03 +0100
References: <45BE4ED0.5030808@us.ibm.com> <200701300839.05144.arnd@arndb.de>
	<45C51F6C.7080300@us.ibm.com>
In-Reply-To: <45C51F6C.7080300@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702040352.03792.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	oprofile-list@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 04 February 2007 00:49, Maynard Johnson wrote:
> I seem to recall looking at this option a while back, but didn't go that=
=20
> route since struct spu_context is opaque to me. =A0With such a teqnique, =
I=20
> could then use a simple 16-element array of =A0pointers to cached_info=20
> objects, creating them as needed when spu_context->profile_private is=20
> NULL. =A0I suppose the better option for now is to add a=20
> get_profile_private() function to SPUFs, rather than requiring=20
> spu_context to be visible.

Yes, that sounds good. Note that the file providing the=20
spufs_get_profile_private (and respective spufs_set_profile_private)
functions needs to be compiled into the kernel then in case oprofile
gets linked in but spufs is a module.

I think it would also be necessary to have another interface for cleaning
up this data when spufs destroys the context. That could possibly
a variation of the existing notifier call, or a new call, or you
establish the convention that if the private pointer is non-NULL,
spufs will kfree it.

	Arnd <><
