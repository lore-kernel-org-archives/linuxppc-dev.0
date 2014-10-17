Return-Path: <ddstreet@gmail.com>
Received: from mail-wi0-x230.google.com (mail-wi0-x230.google.com
 [IPv6:2a00:1450:400c:c05::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 60F561A02B6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Oct 2014 09:05:27 +1100 (AEDT)
Received: by mail-wi0-f176.google.com with SMTP id hi2so3121732wib.15
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Oct 2014 15:05:22 -0700 (PDT)
MIME-Version: 1.0
Sender: ddstreet@gmail.com
In-Reply-To: <1413499949.4567.3.camel@pasglop>
References: <1413487819-6119-1-git-send-email-ddstreet@ieee.org>
 <1413499435.28062.2.camel@concordia> <1413499949.4567.3.camel@pasglop>
From: Dan Streetman <ddstreet@ieee.org>
Date: Fri, 17 Oct 2014 18:05:01 -0400
Message-ID: <CALZtONAvDZWqz5tcE3wV6baC1fEa-27+4jDoEN+iWwvsL7c-NA@mail.gmail.com>
Subject: Re: [PATCH] drivers/crypto/nx: prevent oops on module exit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, nfont@linux.vnet.ibm.com
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, Seth Jennings <sjennings@variantweb.net>,
 Robert Jennings <rcj4747@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Yep, I own the driver now, I'll send a maintainers patch.


On Thu, Oct 16, 2014 at 6:52 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2014-10-17 at 09:43 +1100, Michael Ellerman wrote:
>> On Thu, 2014-10-16 at 15:30 -0400, Dan Streetman wrote:
>> > Check old_devdata->dev in nx-842 driver before accessing it, as
>> > on systems without any nx-842 hardware, the ->dev will never be
>> > set.  Currently, the module will cause an oops during unload
>> > since old_devdata->dev is null.
>>
>> Hi Dan,
>>
>> Patch looks reasonable. But I can't merge it, at least not without an ACK:
>>
>> $ ./scripts/get_maintainer.pl -f drivers/crypto/nx/
>> Nathan Fontenot <nfont@linux.vnet.ibm.com> (supporter:IBM Power 842 com...)
>> Marcelo Henrique Cerri <mhcerri@linux.vnet.ibm.com> (supporter:IBM Power in-Nest...)
>> Fionnuala Gunter <fin@linux.vnet.ibm.com> (supporter:IBM Power in-Nest...)
>> Herbert Xu <herbert@gondor.apana.org.au> (maintainer:CRYPTO API)
>> "David S. Miller" <davem@davemloft.net> (maintainer:CRYPTO API)
>> linux-crypto@vger.kernel.org (open list:IBM Power in-Nest...)
>> linux-kernel@vger.kernel.org (open list)
>>
>>
>> If any of the above is out of date please send me a patch for MAINTAINERS.
>
> I think Dan now owns that driver, Dan, please confirm.
>
> Cheers,
> Ben.
>
>
