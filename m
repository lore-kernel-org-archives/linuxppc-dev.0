Date: Tue, 22 Jan 2002 15:22:01 -0600
From: "Joseph P. Garcia" <jpgarcia@execpc.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: ide-pmac module-ation
Message-Id: <20020122152201.2ffd9da1.jpgarcia@execpc.com>
In-Reply-To: <20020120210234.19509@smtp.wanadoo.fr>
References: <20020120143900.588a4949.jpgarcia@execpc.com>
	<20020120210234.19509@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 20 Jan 2002 22:02:34 +0100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> Also, doing it from within ide-pmac will probably help toward making
> ide-pmac moduleable ;)

Ok.  I see that now.  My bad.  There is new structure in BK devel's asm/ide.h called ppc_ide_md that has all these things.  platforms/pmac_setup.c sets the functions that it defines itself.  So in following that, ide_pmac.c should do that in an init or probe call (and clear it in mod_cleanup when that is implemented).

add a 'ppc_ide_md.ide_init_hwif=pmac_ide_init_hwif_ports' at the end of the probe in ide-pmac.c and hotswap works again.

--
Joseph P. Garcia
http://www.lycestra.com/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
