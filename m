Return-Path: <jeremy@goop.org>
Message-ID: <44A2A396.4000202@goop.org>
Date: Wed, 28 Jun 2006 08:43:18 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-mm2
References: <449D5D36.3040102@google.com>	<449FF3A2.8010907@mbligh.org>	<44A150C9.7020809@mbligh.org>
	<20060628034215.c3008299.akpm@osdl.org>
In-Reply-To: <20060628034215.c3008299.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org, mbligh@google.com,
	"Martin J. Bligh" <mbligh@mbligh.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew Morton wrote:
> This is caused by the vsprintf() changes.  Right now, if you do
>
> 	snprintf(buf, 4, "1111111111111");
>
> the memory at `buf' gets [31 31 31 31 00], which is not good.
>
> This'll plug it, but I didn't check very hard whether it still has any
> off-by-ones, or if breaks the intent of Jeremy's patch.  I think it's OK..
>   
Damn.  This patch doesn't look right; the intent is that 'end' point to 
just beyond the formatted string.  I'm pretty sure I tested this, since 
its the most obvious test.  Clearly not enough.  I'll look into it.

    J
