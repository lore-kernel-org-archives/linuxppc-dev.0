Return-Path: <jonsmirl@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.233])
	by ozlabs.org (Postfix) with ESMTP id BFAE9DDDE3
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 13:57:23 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so2056022rvb.9
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Oct 2008 19:57:22 -0700 (PDT)
Message-ID: <9e4733910810201957r59433e74xbdeef6a035f3f9ee@mail.gmail.com>
Date: Mon, 20 Oct 2008 22:57:22 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] Format string bug in drivers/of/of_i2c.c
In-Reply-To: <1224557565.7654.222.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20081020121315.10428.10730.stgit@terra>
	<1224557565.7654.222.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Format string bug.  Not exploitable, as this is only writable by root,
but worth fixing all the same.

See 326f6a5c9c9e1a62aec37bdc0c3f8d53adabe77b

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---
 drivers/of/of_i2c.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
index 6a98dc8..24bbef7 100644
--- a/drivers/of/of_i2c.c
+++ b/drivers/of/of_i2c.c
@@ -41,7 +41,7 @@ void of_register_i2c_devices(struct i2c_adapter *adap,

 		info.addr = *addr;

-		request_module(info.type);
+		request_module("%s", info.type);

 		result = i2c_new_device(adap, &info);
 		if (result == NULL) {
