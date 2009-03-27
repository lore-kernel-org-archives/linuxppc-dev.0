Return-Path: <albrecht.dress@arcor.de>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id ABA3DDDDFA
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Mar 2009 00:05:11 +1100 (EST)
Received: from mail-in-09-z2.arcor-online.net (mail-in-09-z2.arcor-online.net
	[151.189.8.21]) by mx.arcor.de (Postfix) with ESMTP id 3D22011FFDC
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2009 14:05:05 +0100 (CET)
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	by mail-in-09-z2.arcor-online.net (Postfix) with ESMTP id BE6FC28EDD0
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2009 14:05:04 +0100 (CET)
Received: from webmail11.arcor-online.net (webmail11.arcor-online.net
	[151.189.8.83])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 79A6828F2EF
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2009 14:05:04 +0100 (CET)
Message-ID: <17008330.1238159104446.JavaMail.ngmail@webmail11.arcor-online.net>
Date: Fri, 27 Mar 2009 14:05:04 +0100 (CET)
From: "Albrecht Dreﬂ" <albrecht.dress@arcor.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Q: define i2c nodes in device tree?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Timur:

> You need to have a "gpio I2C" device driver that registers the same name =
as what's in the DTS, like this:

Thanks, that did the trick; a proper naming is apparently

pca8575:gpio@20 {
        compatible =3D "nxp,pca8575";
        device_type =3D "gpio";
        reg =3D <0x20 1>;
};

Now the driver is called, but complains that no platform data is present.  =
Still have to figure out how to pass that... :-/

An other confusing thing: although the probe function fails with error -EIN=
VAL, the device gets registered:

<7>[    0.801814] i2c 1-0020: uevent
<7>[    0.802213] pcf857x 1-0020: probe
<7>[    0.802236] pcf857x 1-0020: no platform data
<4>[    0.802265] pcf857x: probe of 1-0020 failed with error -22
<7>[    0.807980] i2c-adapter i2c-1: client [pca8575] registered with bus i=
d 1-0020

# ls -al /sys/devices/f0000000.soc5200/f0003d40.i2c/i2c-adapter/i2c-1/
drwxr-xr-x    6 0        0               0 Jan  1 00:00 .
drwxr-xr-x    3 0        0               0 Jan  1 00:00 ..
drwxr-xr-x    2 0        0               0 Jan  1 00:00 1-0020
drwxr-xr-x    2 0        0               0 Jan  1 00:00 1-0021
drwxr-xr-x    2 0        0               0 Jan  1 00:00 1-0022
[...]

Is this the intended behaviour?

Thanks, Albrecht.

Zerrei=DFen Sie die Netze der Phisher, Hacker und Betr=FCger!
Ihre Internet-Sicherheits-Seiten auf Arcor.de bieten alle Infos und Hilfsmi=
ttel, die Sie zum sicheren Surfen brauchen! Play it safe!
http://www.arcor.de/footer-sicherheit/
