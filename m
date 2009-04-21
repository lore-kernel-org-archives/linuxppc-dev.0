Return-Path: <mmlnx@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BAFBBDE03F
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 04:55:57 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n3LIoRZ9014581
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 12:50:27 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n3LItpLX077592
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 12:55:51 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n3LItonh013546
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 12:55:51 -0600
Message-ID: <49EE16B4.4000504@us.ibm.com>
Date: Tue, 21 Apr 2009 11:55:48 -0700
From: Mike Mason <mmlnx@us.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Set error_state to pci_channel_io_normal in
	eeh_report_reset()
References: <49DF967F.4000205@us.ibm.com>
	<18917.31205.828267.202889@drongo.ozlabs.ibm.com>
In-Reply-To: <18917.31205.828267.202889@drongo.ozlabs.ibm.com>
Content-Type: text/html; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linasvepstas@gmail.com,
	Richard Lary <rlary@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Paul Mackerras wrote:
<blockquote cite="mid:18917.31205.828267.202889@drongo.ozlabs.ibm.com"
 type="cite">
  <pre wrap="">Mike Mason writes:

  </pre>
  <blockquote type="cite">
    <pre wrap="">diff --git a/arch/powerpc/platforms/pseries/eeh_driver.c 
b/arch/powerpc/platforms/pseries/eeh_driver.c
index 380420f..9a2a6e3 100644
--- a/arch/powerpc/platforms/pseries/eeh_driver.c
+++ b/arch/powerpc/platforms/pseries/eeh_driver.c
@@ -182,6 +182,8 @@ static void eeh_report_reset(struct pci_dev *dev, 
void *userdata)
if (!driver)
return;

+ dev-&gt;error_state = pci_channel_io_normal;
+
eeh_enable_irq(dev);

if (!driver-&gt;err_handler ||
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Your mail client totally mangled the whitespace.  I fixed it up and
applied it, since the patch was small, but in future please fix your
mail client so it doesn't do that.
  </pre>
</blockquote>
Sorry about that.<br>
<blockquote cite="mid:18917.31205.828267.202889@drongo.ozlabs.ibm.com"
 type="cite">
  <pre wrap="">
It sounds like this patch needs to be applied to earlier kernel
versions -- do you agree?
  </pre>
</blockquote>
Maybe.&nbsp; The only drivers that care at this point are the emulex and
qlogic drivers with native eeh support.&nbsp; How far back would you
typically apply a patch like this?&nbsp; I'm submitting it for inclusion in
SLES 10 &amp; 11 and RHEL 5.<br>
<br>
Mike<br>
<blockquote cite="mid:18917.31205.828267.202889@drongo.ozlabs.ibm.com"
 type="cite">
  <pre wrap="">
Paul.
  </pre>
</blockquote>
</body>
</html>
