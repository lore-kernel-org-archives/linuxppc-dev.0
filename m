Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 07/15] Don't return -ENOSYS as extra notes size if spufs
	is not loaded
Date: Wed, 12 Sep 2007 13:04:57 +0200
References: <2900ea4dbfd6e98e71ff400cbd25d1283a278972.1189583010.git.michael@ellerman.id.au>
	<628a383203480c3ce59125feccc32168de919014.1189583010.git.michael@ellerman.id.au>
In-Reply-To: <628a383203480c3ce59125feccc32168de919014.1189583010.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709121304.58140.arnd@arndb.de>
Cc: Jeremy Kerr <jk@ozlabs.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 12 September 2007, Michael Ellerman wrote:
> Because the SPU coredump code might be built as part of a module (spufs),
> we have a stub which is called by the coredump code, this routine then calls
> into spufs if it's loaded.
> 
> Unfortunately the stub returns -ENOSYS if spufs is not loaded, which is
> interpreted by the coredump code as an extra note size of -38 bytes. This
> leads to a corrupt core dump.
> 
> If spufs is not loaded there will be no SPU ELF notes to write, and so the
> extra notes size will be == 0.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
