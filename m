Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 9A13EDDDA9
	for <linuxppc-dev@ozlabs.org>; Sun,  3 May 2009 17:04:55 +1000 (EST)
Date: Sun, 3 May 2009 03:04:53 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "linuxppc-dev" <linuxppc-dev@ozlabs.org>
Subject: Re: unexpected non-allocatable section
Message-ID: <20090503030453.592434e1@lappy.seanm.ca>
In-Reply-To: <20090502224126.641c63bf@lappy.seanm.ca>
References: <20090502224126.641c63bf@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

b614a697dc17dff82f140d72d21a095f810fa7fb is first bad commit
commit b614a697dc17dff82f140d72d21a095f810fa7fb
Author: Anders Kaseorg <andersk@mit.edu>
Date:   Thu Apr 23 16:49:33 2009 -0400

    kbuild, modpost: Check the section flags, to catch missing "ax"/"aw"
    
    When you put
      .section ".foo"
    in an assembly file instead of
      .section "foo", "ax"
    , one of the possible symptoms is that modpost will see an
    ld-generated section name ".foo.1" in section_rel() or section_rela().
    But this heuristic has two problems: it will miss a bad section that
    has no relocations, and it will incorrectly flag many gcc-generated
    sections as bad when compiling with -ffunction-sections
    -fdata-sections.
    
    On mips it fixes a lot of bogus warnings with gcc 4.4.0 lije this one:
    WARNING: crypto/cryptd.o (.text.T.349): unexpected section name.
    
    So instead of checking whether the section name matches a particular
    pattern, we directly check for a missing SHF_ALLOC in the section
    flags.
    
    Signed-off-by: Anders Kaseorg <andersk@mit.edu>
    Tested-by: Ralf Baechle <ralf@linux-mips.org>
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

:040000 040000 9931d6ed1b6f9e836517162b15e757c8ad13d69e f1134de951b415eb7f5831898c827daf93c96c1a M      scripts
