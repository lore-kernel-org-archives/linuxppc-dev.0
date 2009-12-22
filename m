Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 410A5B7BDF
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Dec 2009 02:38:37 +1100 (EST)
Received: from bzq-82-81-146-158.red.bezeqint.net ([82.81.146.158]:50909
	helo=[10.0.0.3]) by vega.surpasshosting.com with esmtpa (Exim 4.69)
	(envelope-from <felix@embedded-sol.com>) id 1NN6oj-0003T6-Ah
	for linuxppc-dev@ozlabs.org; Tue, 22 Dec 2009 10:38:33 -0500
Message-ID: <4B30E7F5.8080201@embedded-sol.com>
Date: Tue, 22 Dec 2009 17:38:29 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: I2C bus clock on MPC85XX systems
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Almost all MPC85XX based systems have the compatible=:"fsl-i2c" in 
respective
i2c device tree nodes. This causes FSL i2c driver to use the following 
"backward
compatible" values: FSR=0x31 DFSR=0x10. This is regardless of CCB clock
frequency and i2c clock prescaler.

On my custom MPC8536 based board with 432MHz CCB clock this results in
65KHz i2c clock frequency (checked with scope). U-Boot correctly configures
the clock to 400KHz.

I've fixed the problem by modifying device tree to use different 
compatible value,
similar to what socrates board does. Is this the right approach ?

Thanks.

Felix.
