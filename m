Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41hjxh5fqMzF12N
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2018 20:31:04 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH 1/2] of: Add of_machine_compatible_match()
In-Reply-To: <CAL_JsqKYFk6-ofDFvaiy3a+r8Zyzw2UuMQUHb-RrgeWfpjom5w@mail.gmail.com>
References: <20180730131516.18406-1-mpe@ellerman.id.au>
 <CAL_JsqKYFk6-ofDFvaiy3a+r8Zyzw2UuMQUHb-RrgeWfpjom5w@mail.gmail.com>
Date: Fri, 03 Aug 2018 20:31:03 +1000
Message-ID: <87efffhhco.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rob Herring <robh+dt@kernel.org> writes:
> On Mon, Jul 30, 2018 at 7:15 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
...
>> diff --git a/include/linux/of.h b/include/linux/of.h
>> index 4d25e4f952d9..05e3e23a3a57 100644
>> --- a/include/linux/of.h
>> +++ b/include/linux/of.h
>> @@ -389,6 +389,7 @@ extern int of_alias_get_id(struct device_node *np, const char *stem);
>>  extern int of_alias_get_highest_id(const char *stem);
>>
>>  extern int of_machine_is_compatible(const char *compat);
>> +extern bool of_machine_compatible_match(const char *const *compats);
>
> Would be nice if of_machine_is_compatible could be implemented in
> terms of of_machine_compatible_match like this:
>
> int of_machine_is_compatible(const char *compat)
> {
>   const char *compats[] = { compat, NULL };
>   return of_machine_is_compatible(compats);
> }
>
> Probably can be inline too.

Yeah good idea, I'll do a v2 next week.

cheers
