Return-Path: <anton@samba.org>
Date: Mon, 7 Apr 2014 09:55:11 +1000
From: Anton Blanchard <anton@samba.org>
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH] powerpc/le: Avoid creatng R_PPC64_TOCSAVE relocations
 for modules.
Message-ID: <20140407095511.7677da8b@kryten>
In-Reply-To: <20140312041201.GA13555@thor.bakeyournoodle.com>
References: <20140312041201.GA13555@thor.bakeyournoodle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Rusty Russell <rusty@rustcorp.com.au>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>, Alan Modra <amodra@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Tony,

> When building modules with a native le toolchain the linker will
> generate R_PPC64_TOCSAVE relocations when it's safe to omit saving r2
> on a plt call.  This isn't helpful in the conext of a kernel module
> and the kernel will fail to load those modules with an error like:
> 	nf_conntrack: Unknown ADD relocation: 109
> 
> This patch tells the linker to avoid createing R_PPC64_TOCSAVE
> relocations allowing modules to load.

Looks good.

Signed-off-by: Anton Blanchard <anton@samba.org>

> +ifeq ($(call cc-option-yn,-mno-save-toc-indirect),y)
> +       KBUILD_CFLAGS_MODULE += -mno-save-toc-indirect
> +endif

Low priority bikeshedding, but could we save ourselves a few lines with:

KBUILD_CFLAGS_MODULE += $(call cc-option,-mno-save-toc-indirect)

Anton
