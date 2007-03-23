Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <20070323120619.GA7472@localhost.localdomain>
References: <1174544624.10836.24.camel@localhost.localdomain>
	<94d8e19d4b061504fcfd08d1ab70cc78@kernel.crashing.org>
	<20070323120619.GA7472@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <94FD59E6-B618-4AB2-9BAB-D40A70CC1589@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] force -mno-string option on cell
Date: Fri, 23 Mar 2007 08:37:16 -0500
To: Akinobu Mita <mita@fixstars.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@samba.org>,
	cbe-oss-dev@ozlabs.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 23, 2007, at 7:06 AM, Akinobu Mita wrote:

> GCC may generate inline copy loop to handle memcpy() function
> instead of kernel defined memcpy() with -mstring or -Os.
> But this inlined version of memcpy() caused an alignment interrupt
> when copying from SPU local store on PS3.
> (http://ozlabs.org/pipermail/cbe-oss-dev/2007-March/001348.html)
>
> This patch deletes -mstring option on all powerpc and force -mno- 
> string
> option on Cell.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Akinobu Mita <mita@fixstars.com>

Nack.  If GCC is now putting string instructions even if you don't  
specify -mstring than we also need this for CONFIG_FSL_BOOKE.  Please  
fix that up as well.

- k

> ---
>  arch/powerpc/Makefile |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> Index: 2.6-git-ps3/arch/powerpc/Makefile
> ===================================================================
> --- 2.6-git-ps3.orig/arch/powerpc/Makefile
> +++ 2.6-git-ps3/arch/powerpc/Makefile
> @@ -102,8 +102,9 @@ CFLAGS += $(call cc-option,-mno-altivec)
>  # kernel considerably.
>  CFLAGS += $(call cc-option,-funit-at-a-time)
>
> -ifndef CONFIG_FSL_BOOKE
> -CFLAGS		+= -mstring
> +# No string instruction for SPE local store areas
> +ifeq ($(CONFIG_PPC_CELL),y)
> +CFLAGS		+= -mno-string
>  endif
>
>  ifeq ($(CONFIG_6xx),y)
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
