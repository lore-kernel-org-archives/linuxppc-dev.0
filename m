Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7A4A12C0359
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Feb 2014 03:28:11 +1100 (EST)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 2/2] of: search the best compatible match first in
 __of_match_node()
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CAL_JsqKq4_1K8EF+PZoP=0=H6tiRxbgdzs9UHHVdbHS014n74Q@mail.gmail.com>
Date: Fri, 14 Feb 2014 10:23:42 -0600
Message-Id: <A27612FE-F84F-460D-B573-F891B75A70F2@kernel.crashing.org>
References: <1392355366-1445-1-git-send-email-haokexin@gmail.com>
 <1392355366-1445-3-git-send-email-haokexin@gmail.com>
 <CAL_JsqKq4_1K8EF+PZoP=0=H6tiRxbgdzs9UHHVdbHS014n74Q@mail.gmail.com>
To: Rob Herring <robherring2@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Kevin Hao <haokexin@gmail.com>, Stephen N Chivers <schivers@csc.com.au>,
 Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 14, 2014, at 9:53 AM, Rob Herring <robherring2@gmail.com> wrote:

> On Thu, Feb 13, 2014 at 11:22 PM, Kevin Hao <haokexin@gmail.com> =
wrote:
>> Currently, of_match_node compares each given match against all node's
>> compatible strings with of_device_is_compatible.
>>=20
>> To achieve multiple compatible strings per node with ordering from
>> specific to generic, this requires given matches to be ordered from
>> specific to generic. For most of the drivers this is not true and =
also
>> an alphabetical ordering is more sane there.
>>=20
>> Therefore, this patch introduces a function to match each of the =
node's
>> compatible strings against all given compatible matches without type =
and
>> name first, before checking the next compatible string. This implies
>> that node's compatibles are ordered from specific to generic while
>> given matches can be in any order. If we fail to find such a match
>> entry, then fall-back to the old method in order to keep =
compatibility.
>>=20
>> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>> Signed-off-by: Kevin Hao <haokexin@gmail.com>
>=20
> Looks good to me. I'll put this in next for a few days. I'd really
> like to see some acks and tested-by's before sending to Linus.
>=20
> We could be a bit more strict here and fallback to the old matching if
> the match table has any entries with name or type. I don't think that
> should be necessary though.
>=20
> Rob
>=20


Can you push the revert to Linus sooner, since currently a ton of boards =
wouldn=92t be working on the PPC side, so at least -rc3 has the =
possibility of working for them.

- k
