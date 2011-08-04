Return-Path: <hector@marcansoft.com>
Message-ID: <4E3A7EC6.2000908@marcansoft.com>
Date: Thu, 04 Aug 2011 13:13:10 +0200
From: Hector Martin <hector@marcansoft.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 03/15] [PS3] Add region 1 memory early
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>	<1312228986-32307-4-git-send-email-a.heider@gmail.com>	<4E39CC79.3050208@infradead.org>	<4E39E302.9060702@marcansoft.com>
	<CAMuHMdWuefw8WM+320vr--uWTjiFo6hJrinD4HuzNFSZcM8sjQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWuefw8WM+320vr--uWTjiFo6hJrinD4HuzNFSZcM8sjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: Geoff Levand <geoff@infradead.org>, cbe-oss-dev@lists.ozlabs.org,
	Andre Heider <a.heider@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/04/2011 09:05 AM, Geert Uytterhoeven wrote:
> The reason for that is to make sure the allocations will succeed.
> Chances are very
> slim you can allocate a contiguous 9 MiB buffer at any arbitrary time.

Fair enough, but then they don't need to happen as early as they do now;
any time during kernel startup should work (as long as they aren't freed
with the drivers if they're unloaded). How about switching to
__get_free_pages and doing the allocation inside an arch_initcall or
similar?

-- 
Hector Martin (hector@marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc
