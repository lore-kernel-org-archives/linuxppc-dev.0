Return-Path: <SRS0=wj8a=DA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C76C4363D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2020 14:21:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEF9221D92
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2020 14:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org; dmarc=permerror header.from=scram.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BxL2w4HLWzDqWX
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2020 00:21:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=scram.de (client-ip=2a01:4f8:130:2201::3; helo=mail.scram.de;
 envelope-from=jochen@scram.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=permerror header.from=scram.de
X-Greylist: delayed 162 seconds by postgrey-1.36 at bilbo;
 Thu, 24 Sep 2020 00:16:26 AEST
Received: from mail.scram.de (mail0.scram.de [IPv6:2a01:4f8:130:2201::3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BxKwp2GTQzDqNG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2020 00:16:25 +1000 (AEST)
Received: from localhost (mail0.scram.de [78.47.204.202])
 by localhost (Postfix) with ESMTP id B8B2057377;
 Wed, 23 Sep 2020 16:13:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at scram.de
Received: from mail.scram.de ([78.47.204.202])
 by localhost (mail.scram.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1OVkS7QmSj1S; Wed, 23 Sep 2020 16:12:49 +0200 (CEST)
Received: (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate) (Authenticated sender)
 by mail.scram.de (Postfix) with ESMTPSA id 8B9C156CC7;
 Wed, 23 Sep 2020 16:12:49 +0200 (CEST)
Subject: Re: [PATCH v2] i2c: cpm: Fix i2c_ram structure
To: nicolas.vincent@vossloh.com
References: <20200923140840.8700-1-nicolas.vincent@vossloh.com>
From: Jochen Friedrich <jochen@scram.de>
Message-ID: <b518e49b-87d7-55bb-42f3-619b83f90b6d@scram.de>
Date: Wed, 23 Sep 2020 16:12:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200923140840.8700-1-nicolas.vincent@vossloh.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Acked-by: Jochen Friedrich <jochen@scram.de>

Am 23.09.2020 um 16:08 schrieb nico.vince@gmail.com:
> From: Nicolas VINCENT <nicolas.vincent@vossloh.com>
> 
> the i2c_ram structure is missing the sdmatmp field mentionned in
> datasheet for MPC8272 at paragraph 36.5. With this field missing, the
> hardware would write past the allocated memory done through
> cpm_muram_alloc for the i2c_ram structure and land in memory allocated
> for the buffers descriptors corrupting the cbd_bufaddr field. Since this
> field is only set during setup(), the first i2c transaction would work
> and the following would send data read from an arbitrary memory
> location.
> 
> Signed-off-by: Nicolas VINCENT <nicolas.vincent@vossloh.com>
> ---
>   drivers/i2c/busses/i2c-cpm.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
> index 1213e1932ccb..24d584a1c9a7 100644
> --- a/drivers/i2c/busses/i2c-cpm.c
> +++ b/drivers/i2c/busses/i2c-cpm.c
> @@ -65,6 +65,9 @@ struct i2c_ram {
>   	char    res1[4];	/* Reserved */
>   	ushort  rpbase;		/* Relocation pointer */
>   	char    res2[2];	/* Reserved */
> +	/* The following elements are only for CPM2 */
> +	char    res3[4];	/* Reserved */
> +	uint    sdmatmp;	/* Internal */
>   };
>   
>   #define I2COM_START	0x80
> 
