Return-Path: <neelegup@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DE6981A0063
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 15:35:05 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <neelegup@linux.vnet.ibm.com>;
 Wed, 3 Jun 2015 15:35:04 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 85A8E3578053
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 15:35:01 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t535Yri19502768
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jun 2015 15:35:01 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t535YSMR008359
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jun 2015 15:34:29 +1000
Message-ID: <556E91D3.8010707@linux.vnet.ibm.com>
Date: Wed, 03 Jun 2015 11:04:11 +0530
From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] rtc/rtc-opal: Disable rtc-alarms when opal doesn't support
 tpo
References: <1433307087-11503-1-git-send-email-vaibhav@linux.vnet.ibm.com>
In-Reply-To: <1433307087-11503-1-git-send-email-vaibhav@linux.vnet.ibm.com>
Content-Type: multipart/alternative;
 boundary="------------050405080803000305050001"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------050405080803000305050001
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit



On 06/03/2015 10:21 AM, Vaibhav Jain wrote:
> rtc-opal driver provides support for rtc alarms via
> times-power-on(tpo). However some platforms like BML use a fake rtc
> clock and don't support tpo. Such platforms are indicated by the missing
> 'has-tpo' property in the device tree.
>
> Current implementation however enables callback for
> rtc_class_ops.read/set alarm irrespective of the tpo support from the
> platform. This results in a failed opal call when kernel tries to read
> an existing alarms via opal_get_tpo_time during rtc device registration.
>
> This patch fixes this issue by setting opal_rtc_ops.read/set_alarm
> callback pointers only when tpo is supported.
>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

Acked-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>

Thanks,
Neelesh.

> ---
>   drivers/rtc/rtc-opal.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/rtc/rtc-opal.c b/drivers/rtc/rtc-opal.c
> index 7061dca..1125641 100644
> --- a/drivers/rtc/rtc-opal.c
> +++ b/drivers/rtc/rtc-opal.c
> @@ -190,11 +190,9 @@ exit:
>   	return rc;
>   }
>
> -static const struct rtc_class_ops opal_rtc_ops = {
> +static struct rtc_class_ops opal_rtc_ops = {
>   	.read_time	= opal_get_rtc_time,
>   	.set_time	= opal_set_rtc_time,
> -	.read_alarm	= opal_get_tpo_time,
> -	.set_alarm	= opal_set_tpo_time,
>   };
>
>   static int opal_rtc_probe(struct platform_device *pdev)
> @@ -202,8 +200,11 @@ static int opal_rtc_probe(struct platform_device *pdev)
>   	struct rtc_device *rtc;
>
>   	if (pdev->dev.of_node && of_get_property(pdev->dev.of_node, "has-tpo",
> -						 NULL))
> +						 NULL)) {
>   		device_set_wakeup_capable(&pdev->dev, true);
> +		opal_rtc_ops.read_alarm	= opal_get_tpo_time;
> +		opal_rtc_ops.set_alarm = opal_set_tpo_time;
> +	}
>
>   	rtc = devm_rtc_device_register(&pdev->dev, DRVNAME, &opal_rtc_ops,
>   				       THIS_MODULE);


--------------050405080803000305050001
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=windows-1252"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <br>
    <br>
    <div class="moz-cite-prefix">On 06/03/2015 10:21 AM, Vaibhav Jain
      wrote:<br>
    </div>
    <blockquote
      cite="mid:1433307087-11503-1-git-send-email-vaibhav@linux.vnet.ibm.com"
      type="cite">
      <pre wrap="">rtc-opal driver provides support for rtc alarms via
times-power-on(tpo). However some platforms like BML use a fake rtc
clock and don't support tpo. Such platforms are indicated by the missing
'has-tpo' property in the device tree.

Current implementation however enables callback for
rtc_class_ops.read/set alarm irrespective of the tpo support from the
platform. This results in a failed opal call when kernel tries to read
an existing alarms via opal_get_tpo_time during rtc device registration.

This patch fixes this issue by setting opal_rtc_ops.read/set_alarm
callback pointers only when tpo is supported.

Signed-off-by: Vaibhav Jain <a class="moz-txt-link-rfc2396E" href="mailto:vaibhav@linux.vnet.ibm.com">&lt;vaibhav@linux.vnet.ibm.com&gt;</a></pre>
    </blockquote>
    <br>
    <small>Acked-by: Neelesh Gupta <a class="moz-txt-link-rfc2396E" href="mailto:neelegup@linux.vnet.ibm.com">&lt;neelegup@linux.vnet.ibm.com&gt;</a></small><br>
    <br>
    <small>Thanks,</small><br>
    <small>Neelesh.</small><br>
    <br>
    <blockquote
      cite="mid:1433307087-11503-1-git-send-email-vaibhav@linux.vnet.ibm.com"
      type="cite">
      <pre wrap="">
---
 drivers/rtc/rtc-opal.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-opal.c b/drivers/rtc/rtc-opal.c
index 7061dca..1125641 100644
--- a/drivers/rtc/rtc-opal.c
+++ b/drivers/rtc/rtc-opal.c
@@ -190,11 +190,9 @@ exit:
 	return rc;
 }

-static const struct rtc_class_ops opal_rtc_ops = {
+static struct rtc_class_ops opal_rtc_ops = {
 	.read_time	= opal_get_rtc_time,
 	.set_time	= opal_set_rtc_time,
-	.read_alarm	= opal_get_tpo_time,
-	.set_alarm	= opal_set_tpo_time,
 };

 static int opal_rtc_probe(struct platform_device *pdev)
@@ -202,8 +200,11 @@ static int opal_rtc_probe(struct platform_device *pdev)
 	struct rtc_device *rtc;

 	if (pdev-&gt;dev.of_node &amp;&amp; of_get_property(pdev-&gt;dev.of_node, "has-tpo",
-						 NULL))
+						 NULL)) {
 		device_set_wakeup_capable(&amp;pdev-&gt;dev, true);
+		opal_rtc_ops.read_alarm	= opal_get_tpo_time;
+		opal_rtc_ops.set_alarm = opal_set_tpo_time;
+	}

 	rtc = devm_rtc_device_register(&amp;pdev-&gt;dev, DRVNAME, &amp;opal_rtc_ops,
 				       THIS_MODULE);
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------050405080803000305050001--
