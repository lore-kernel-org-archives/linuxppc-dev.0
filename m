Return-Path: <cbouatmailru@gmail.com>
Date: Thu, 10 Jun 2010 20:52:43 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: "M. Warner Losh" <imp@bsdimp.com>
Subject: Re: [PATCH 6/6] of/device: populate platform_device (of_device)
	resource table on allocation
Message-ID: <20100610165243.GA18043@oksana.dev.rtsoft.ru>
References: <AANLkTilpUi1cazljWSFbzliY78RKyHUlvBshUD3NPHPv@mail.gmail.com>
	<20100610.091357.513168276793712624.imp@bsdimp.com>
	<20100610154741.GA7484@oksana.dev.rtsoft.ru>
	<20100610.100140.8559628065321695.imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20100610.100140.8559628065321695.imp@bsdimp.com>
Cc: sfr@canb.auug.org.au, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org, jeremy.kerr@canonical.com,
	microblaze-uclinux@itee.uq.edu.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 10, 2010 at 10:01:40AM -0600, M. Warner Losh wrote:
[...]
> But this requires extra, bogus fields in the structure

False. The [0] field isn't bogus, it has a defined meaning.
It says: here is some amount of resouces may be allocated.

> and creates a bogus sizeof issue.

Creates? False. The same sizeof problem exists in Grant's
approach. sizeof(*dev) != what_we_have_allocated. Which is
isn't great, I agree. And that's exactly why I proposed a
dedicated allocation in the first place.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
