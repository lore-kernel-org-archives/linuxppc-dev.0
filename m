Date: Fri, 25 Jan 2002 08:44:48 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-dev@lists.linuxppc.org
Cc: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: arch/ppc/kernel/setup.c::screen_info
Message-ID: <20020125154448.GB745@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hey all.  Currently in the linuxppc_2_4 tree, we conditionally compile
the screen_info struct on CONFIG_VGA_CONSOLE (and export the symbol
based on that too).  In linuxppc_2_4_devel, Geert checked in vga16fb
fixes 2 months ago or so that added tests for CONFIG_FB_VGA16{,_MODULE}.
And just recently Hollis Blanchard posted a patch to add vesafb to this
list as well.   So now the question is, shouldn't we just blindly
allocate this struct and always export the screen_info symbol?  This
makes the most sense IMHO, since the point of modules is that you can
add things on later without having to recompile.  But if people are
concerned about the extra space, perhaps we should do it based on
CONFIG_FB (I don't believe VGA_CONSOLE actually needs the symbol to be
exported, since it's a bool).   Comments?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
