Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18089.11934.607569.349144@cargo.ozlabs.ibm.com>
Date: Fri, 27 Jul 2007 09:30:38 +1000
From: Paul Mackerras <paulus@samba.org>
To: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] make powerpc BUG_ON() OK with pointers and bitwise
In-Reply-To: <E1IE6JZ-0005QA-R8@ZenIV.linux.org.uk>
References: <E1IE6JZ-0005QA-R8@ZenIV.linux.org.uk>
Cc: linuxppc-dev@ozlabs.org, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Al Viro writes:

> Since powerpc insists on printing the _value_ of condition

We don't _print_ the value of the condition, we give it to a
conditional-trap instruction which will trap if it is non-zero.

> and on casting it to long...  At least let's make it a force-cast.

The long cast is to make sure it's sign-extended to the full register
width.  Adding __force looks fine.

> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Paul Mackerras <paulus@samba.org>
