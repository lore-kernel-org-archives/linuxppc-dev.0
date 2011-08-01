Return-Path: <a.heider@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUgK7ZkaNA+DVg0_TL8fz+AfEOTZqW5WdOY5ybwSP=hcA@mail.gmail.com>
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
	<1312228986-32307-7-git-send-email-a.heider@gmail.com>
	<CAMuHMdUgK7ZkaNA+DVg0_TL8fz+AfEOTZqW5WdOY5ybwSP=hcA@mail.gmail.com>
Date: Mon, 1 Aug 2011 22:56:31 +0200
Message-ID: <CAHsu+b-xtj8DvLS-v_5-QZ3Erc-9jpFd0rodeoc4RU9YPho3tw@mail.gmail.com>
Subject: Re: [Cbe-oss-dev] [PATCH 06/15] ps3flash: Fix region align checks
From: Andre Heider <a.heider@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Geoff Levand <geoff@infradead.org>, cbe-oss-dev@lists.ozlabs.org,
	Hector Martin <hector@marcansoft.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 1, 2011 at 10:29 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Mon, Aug 1, 2011 at 22:02, Andre Heider <a.heider@gmail.com> wrote:
>> The region fields used by the align checks are set in
>> ps3stor_setup(), so move those after that call.
>
> Are you sure?
> Aren't they set in
> arch/powerpc/platforms/ps3/device-init.c:ps3_setup_storage_dev()?

Hm right, unfortunate commit message... :)
dev->region_idx is set in ps3stor_probe_access(), which is called from
ps3stor_setup().
So the code always checked the first region, where it should check the
one beeing used.

Will fix the commit message.

Thanks
