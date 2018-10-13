Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F5EC28CF8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 12:54:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ADFA20645
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 12:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ADFA20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XPmZ47YwzF3HF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 23:54:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=perches.com
 (client-ip=216.40.44.93; helo=smtprelay.hostedemail.com;
 envelope-from=joe@perches.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=perches.com
Received: from smtprelay.hostedemail.com (smtprelay0093.hostedemail.com
 [216.40.44.93])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XPjQ4nLxzF3Cm
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 23:51:53 +1100 (AEDT)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay01.hostedemail.com (Postfix) with ESMTP id E0CA1100E86C8;
 Sat, 13 Oct 2018 12:51:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bait23_fb9a8a32a15d
X-Filterd-Recvd-Size: 5128
Received: from XPS-9350.home (unknown [47.151.153.53])
 (Authenticated sender: joe@perches.com)
 by omf14.hostedemail.com (Postfix) with ESMTPA;
 Sat, 13 Oct 2018 12:51:47 +0000 (UTC)
Message-ID: <97b26203e6792795bdc0a66ce4cdb47571ff16c1.camel@perches.com>
Subject: Re: [PATCH v2 12/18] of: overlay: check prevents multiple fragments
 add or delete same node
From: Joe Perches <joe@perches.com>
To: frowand.list@gmail.com, Rob Herring <robh+dt@kernel.org>, Pantelis
 Antoniou <pantelis.antoniou@konsulko.com>, Michael Ellerman
 <mpe@ellerman.id.au>,  Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>, Moritz
 Fischer <mdf@kernel.org>
Date: Sat, 13 Oct 2018 05:51:46 -0700
In-Reply-To: <1539406418-18162-13-git-send-email-frowand.list@gmail.com>
References: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
 <1539406418-18162-13-git-send-email-frowand.list@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2018-10-12 at 21:53 -0700, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Multiple overlay fragments adding or deleting the same node is not
> supported.  Replace code comment of such, with check to detect the
> attempt and fail the overlay apply.
> 
> Devicetree unittest where multiple fragments added the same node was
> added in the previous patch in the series.  After applying this patch
> the unittest messages will no longer include:
> 
>    Duplicate name in motor-1, renamed to "controller#1"
>    OF: overlay: of_overlay_apply() err=0
>    ### dt-test ### of_overlay_fdt_apply() expected -22, ret=0, overlay_bad_add_dup_node
>    ### dt-test ### FAIL of_unittest_overlay_high_level():2419 Adding overlay 'overlay_bad_add_dup_node' failed
> 
>    ...
> 
>    ### dt-test ### end of unittest - 210 passed, 1 failed
> 
> but will instead include:
> 
>    OF: overlay: ERROR: multiple overlay fragments add and/or delete node /testcase-data-2/substation@100/motor-1/controller
> 
>    ...
> 
>    ### dt-test ### end of unittest - 211 passed, 0 failed
[]
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
[]
> @@ -523,6 +515,54 @@ static int build_changeset_symbols_node(struct overlay_changeset *ovcs,
>  }
>  
>  /**
> + * check_changeset_dup_add_node() - changeset validation: duplicate add node
> + * @ovcs:	Overlay changeset
> + *
> + * Check changeset @ovcs->cset for multiple add node entries for the same
> + * node.
> + *
> + * Returns 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
> + * invalid overlay in @ovcs->fragments[].
> + */
> +static int check_changeset_dup_add_node(struct overlay_changeset *ovcs)
> +{
> +	struct of_changeset_entry *ce_1, *ce_2;
> +	char *fn_1, *fn_2;
> +	int name_match;
> +
> +	list_for_each_entry(ce_1, &ovcs->cset.entries, node) {
> +
> +		if (ce_1->action == OF_RECONFIG_ATTACH_NODE ||
> +		    ce_1->action == OF_RECONFIG_DETACH_NODE) {
> +
> +			ce_2 = ce_1;
> +			list_for_each_entry_continue(ce_2, &ovcs->cset.entries, node) {
> +				if (ce_2->action == OF_RECONFIG_ATTACH_NODE ||
> +				    ce_2->action == OF_RECONFIG_DETACH_NODE) {
> +					/* inexpensive name compare */
> +					if (!of_node_cmp(ce_1->np->full_name,
> +					    ce_2->np->full_name)) {

A bit of odd indentation here.
This line is normally aligned to the second ( on the line above.

> +						/* expensive full path name compare */
> +						fn_1 = kasprintf(GFP_KERNEL, "%pOF", ce_1->np);
> +						fn_2 = kasprintf(GFP_KERNEL, "%pOF", ce_2->np);
> +						name_match = !strcmp(fn_1, fn_2);
> +						kfree(fn_1);
> +						kfree(fn_2);
> +						if (name_match) {
> +							pr_err("ERROR: multiple overlay fragments add and/or delete node %pOF\n",
> +							       ce_1->np);
> +							return -EINVAL;
> +						}
> +					}
> +				}
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}

Style trivia:

Using inverted tests and continue would reduce indentation.

	list_for_each_entry(ce_1, &ovcs->cset.entries, node) {
		if (ce_1->action != OF_RECONFIG_ATTACH_NODE &&
		    ce_1->action != OF_RECONFIG_DETACH_NODE)
			continue;

		ce_2 = ce_1;
		list_for_each_entry_continue(ce_2, &ovcs->cset.entries, node) {
			if (ce_2->action != OF_RECONFIG_ATTACH_NODE &&
			    ce_2->action != OF_RECONFIG_DETACH_NODE)
				continue;

			/* inexpensive name compare */
			if (of_node_cmp(ce_1->np->full_name, ce_2->np->full_name))
				continue;

			/* expensive full path name compare */
			fn_1 = kasprintf(GFP_KERNEL, "%pOF", ce_1->np);
			fn_2 = kasprintf(GFP_KERNEL, "%pOF", ce_2->np);
			name_match = !strcmp(fn_1, fn_2);
			kfree(fn_1);
			kfree(fn_2);
			if (name_match) {
				pr_err("ERROR: multiple overlay fragments add and/or delete node %pOF\n",
				       ce_1->np);
				return -EINVAL;
			}
		}
	}


