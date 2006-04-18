Return-Path: <olof@lixom.net>
Date: Tue, 18 Apr 2006 14:30:31 -0500
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Make rtas console _much_ faster
Message-ID: <20060418193030.GE26746@pb15.lixom.net>
References: <20060418185534.B1ADF679F0@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060418185534.B1ADF679F0@ozlabs.org>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 18, 2006 at 08:55:29PM +0200, Michael Ellerman wrote:

> I'll test this on P5 LPAR, is there anyone else that uses hvc_console?
> Thoughts?

I have an out-of-tree HVC backend here for a simple simulator console
(will never make it in-tree since it's never going to see other users). So
not that it really matters, but the patch is OK for that environment.

The only other case I can think of is if the backend really needs some
time to clear out data, if we end up spinning too much in the yield()
loop. POWER4 with HVC console is a possible candidate there, since all
partitions share a 19200bps line for consoles.

> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Assuming it's not an issue on POWER4 LPAR:

Acked-by: Olof Johansson <olof@lixom.net>
