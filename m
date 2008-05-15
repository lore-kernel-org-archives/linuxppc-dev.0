Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18476.5290.709729.582063@cargo.ozlabs.ibm.com>
Date: Thu, 15 May 2008 20:47:06 +1000
From: Paul Mackerras <paulus@samba.org>
To: Carl Love <cel@us.ibm.com>
Subject: Re: [PATCH] Fix for OProfile callgraph for Power 64 bit user apps
In-Reply-To: <1210183924.7726.28.camel@carll-linux-desktop>
References: <1210183924.7726.28.camel@carll-linux-desktop>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Carl Love writes:

> The following patch fixes the 64 bit user code backtrace 
> which currently may hang the system.  

What exactly is wrong with it?

Having now taken a much closer look, I now don't think Nate Case's
patch addresses this, since it only affects constant size arguments
<= 8 to copy_{to,from}_user_inatomic.

However, I don't see why your patch fixes anything.  It means we do
two access_ok calls and two __copy_from_user_inatomic calls, for 8
bytes, at sp and at sp + 16, rather than doing one access_ok and
__copy_from_user_inatomic for 24 bytes at sp.  Why does that make any
difference (apart from being slower)?

Paul.
