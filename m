Return-Path: <anton@ozlabs.org>
Date: Mon, 8 Feb 2010 11:04:35 +1100
From: Anton Blanchard <anton@samba.org>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: Stack size protection broken on ppc64
Message-ID: <20100208000435.GJ32246@kryten>
References: <3984.1265416993@neuling.org> <20100206042038.GB32246@kryten>
	<10125.1265451732@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <10125.1265451732@neuling.org>
Cc: aeb@cwi.nl, linux-kernel@vger.kernel.org, miltonm@bga.com,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	WANG Cong <xiyou.wangcong@gmail.com>,
	Serge Hallyn <serue@us.ibm.com>, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

> Cool, thanks.  The following is based on this and fixes the problem for
> me on PPC64 ie. the !CONFIG_STACK_GROWSUP case. 

Thanks! Seeing the original setting of EXTRA_STACK_VM_PAGES is more or
less random, I wonder if we should round EXTRA_STACK_VM_SIZE up to 128kB
(or even down to 64kB) so it operates better with > 4kB pages.

But in the end its probably of little use for the default OVERCOMMIT_GUESS
setting, so the main thing is we dont terminate processes incorrectly.

Acked-by: Anton Blanchard <anton@samba.org>

Anton
