Return-Path: <galak@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.11.231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E2C932C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Feb 2014 03:27:37 +1100 (EST)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 2/2] of: search the best compatible match first in
 __of_match_node()
From: Kumar Gala <galak@codeaurora.org>
In-Reply-To: <CAL_JsqKq4_1K8EF+PZoP=0=H6tiRxbgdzs9UHHVdbHS014n74Q@mail.gmail.com>
Date: Fri, 14 Feb 2014 10:19:21 -0600
Message-Id: <B09582EF-9255-46E8-AB61-6E6FFE921AEE@codeaurora.org>
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

Can you push the revert to Linus sooner, since currently a ton of boards =
wouldn=92t be working on the PPC side, so at least -rc3 has the =
possibility of working for them.

- k

>=20
>> ---
>> drivers/of/base.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
>> 1 file changed, 42 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index ba195fbce4c6..10b51106c854 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -730,13 +730,49 @@ out:
>> }
>> EXPORT_SYMBOL(of_find_node_with_property);
>>=20
>> +static const struct of_device_id *
>> +of_match_compatible(const struct of_device_id *matches,
>> +                       const struct device_node *node)
>> +{
>> +       const char *cp;
>> +       int cplen, l;
>> +       const struct of_device_id *m;
>> +
>> +       cp =3D __of_get_property(node, "compatible", &cplen);
>> +       while (cp && (cplen > 0)) {
>> +               m =3D matches;
>> +               while (m->name[0] || m->type[0] || m->compatible[0]) =
{
>> +                       /* Only match for the entries without type =
and name */
>> +                       if (m->name[0] || m->type[0] ||
>> +                               of_compat_cmp(m->compatible, cp,
>> +                                        strlen(m->compatible)))
>> +                               m++;
>> +                       else
>> +                               return m;
>> +               }
>> +
>> +               /* Get node's next compatible string */
>> +               l =3D strlen(cp) + 1;
>> +               cp +=3D l;
>> +               cplen -=3D l;
>> +       }
>> +
>> +       return NULL;
>> +}
>> +
>> static
>> const struct of_device_id *__of_match_node(const struct of_device_id =
*matches,
>>                                           const struct device_node =
*node)
>> {
>> +       const struct of_device_id *m;
>> +
>>        if (!matches)
>>                return NULL;
>>=20
>> +       m =3D of_match_compatible(matches, node);
>> +       if (m)
>> +               return m;
>> +
>>        while (matches->name[0] || matches->type[0] || =
matches->compatible[0]) {
>>                int match =3D 1;
>>                if (matches->name[0])
>> @@ -760,7 +796,12 @@ const struct of_device_id *__of_match_node(const =
struct of_device_id *matches,
>>  *     @matches:       array of of device match structures to search =
in
>>  *     @node:          the of device structure to match against
>>  *
>> - *     Low level utility function used by device matching.
>> + *     Low level utility function used by device matching. We have =
two ways
>> + *     of matching:
>> + *     - Try to find the best compatible match by comparing each =
compatible
>> + *       string of device node with all the given matches =
respectively.
>> + *     - If the above method failed, then try to match the =
compatible by using
>> + *       __of_device_is_compatible() besides the match in type and =
name.
>>  */
>> const struct of_device_id *of_match_node(const struct of_device_id =
*matches,
>>                                         const struct device_node =
*node)
>> --
>> 1.8.5.3

--=20
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, =
hosted by The Linux Foundation
