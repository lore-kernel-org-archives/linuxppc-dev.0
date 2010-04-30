Return-Path: <glikely@secretlab.ca>
Received: from mail-qy0-f175.google.com (mail-qy0-f175.google.com
	[209.85.221.175]) by ozlabs.org (Postfix) with ESMTP id C8C56B7D40
	for <linuxppc-dev@ozlabs.org>; Sat,  1 May 2010 03:43:51 +1000 (EST)
Received: by qyk5 with SMTP id 5so503950qyk.3
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Apr 2010 10:43:49 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <n2kfa686aa41004301035p7e15c017u7a1b98389cc1e466@mail.gmail.com>
References: <4BDAF376.4030005@in.ibm.com> <4BDB12FB.5060806@in.ibm.com>
	<n2kfa686aa41004301035p7e15c017u7a1b98389cc1e466@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 30 Apr 2010 11:43:22 -0600
Message-ID: <g2mfa686aa41004301043i138ffb2dmac5b641fa3d512c4@mail.gmail.com>
Subject: Re: -next Apr 30: OOPS during eHEA driver initialization
To: Sachin Sant <sachinp@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	"linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 30, 2010 at 11:35 AM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> On Fri, Apr 30, 2010 at 11:27 AM, Sachin Sant <sachinp@in.ibm.com> wrote:
>> Sachin Sant wrote:
>>>
>>> With today's next eHEA drivers fails to initialize.
>>
>> If i revert the following patch eHEA network interface is initialized
>> properly.
>>
>> commit cebfe0b6709abdab997c1a00499d67efa32ee1f0
>> drivercore: Add of_match_table to the common device drivers
>
> That is an easy one to fix. =A0I'll get it updated today and send you the=
 result.

Let me know if this patch fixes it:

Cheers,
g.

diff --git a/arch/powerpc/kernel/ibmebus.c b/arch/powerpc/kernel/ibmebus.c
index ce957a4..693b0e6 100644
--- a/arch/powerpc/kernel/ibmebus.c
+++ b/arch/powerpc/kernel/ibmebus.c
@@ -201,6 +201,9 @@ static int ibmebus_create_devices(const struct
of_device_id *matches)

 int ibmebus_register_driver(struct of_platform_driver *drv)
 {
+	if (!drv->driver.of_match_table)
+		drv->driver.of_match_table =3D drv->match_table;
+
 	/* If the driver uses devices that ibmebus doesn't know, add them */
 	ibmebus_create_devices(drv->driver.of_match_table);



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
