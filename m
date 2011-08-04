Return-Path: <hector@marcansoft.com>
Message-ID: <4E39E302.9060702@marcansoft.com>
Date: Thu, 04 Aug 2011 02:08:34 +0200
From: Hector Martin <hector@marcansoft.com>
MIME-Version: 1.0
To: Geoff Levand <geoff@infradead.org>
Subject: Re: [PATCH 03/15] [PS3] Add region 1 memory early
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
	<1312228986-32307-4-git-send-email-a.heider@gmail.com>
	<4E39CC79.3050208@infradead.org>
In-Reply-To: <4E39CC79.3050208@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: cbe-oss-dev@lists.ozlabs.org, Andre Heider <a.heider@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/04/2011 12:32 AM, Geoff Levand wrote:
> We need an explanation of this change.

I actually have a hard time understanding the reason for the existing
behavior of hot-adding memory halfway through the boot process. Maybe
you can shed some light on this?

The reason for the change is that under the default GameOS LPAR, real
mode memory is 16MB which is already tight for a kernel (under certain
conditions) and runs out quickly as memory is allocated during kernel
startup. Having region1 available sooner fixes this.

Though, reviewing the code, I think I found a bug (that should already
have a chance of happening as things stand now, though this patch might
make it more likely): if storage bounce buffers or the ps3fb xdr happen
to straddle the boundary between the regions, bad things will happen
since they're not actually contiguous in LPAR space. This won't happen
right now for ps3flash or ps3fb since those are allocated early out of
bootmem, but it can currently happen for the other buffers (ps3disk,
ps3vram, etc.) AFAICT.

Maybe we should introduce a reserved or nonexistent page gap at the
beginning of region1 to ensure that nothing will ever allocate
contiguous memory across the boundary. That will probably prevent
bootmem from grabbing region1 due to the gap, so early on memory will be
tight. Can we get rid of the ps3flash and ps3fb preallocations to save
bootmem and just allocate them during device init like the other drivers
do? What is the reason for preallocating these?

-- 
Hector Martin (hector@marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc
