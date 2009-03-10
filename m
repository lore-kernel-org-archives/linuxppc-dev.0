Return-Path: <johns.daniel@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id DFF41DDE41
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 10:02:48 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id d14so1149092and.39
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 16:02:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ba5d9360903101553h3cf7c33ex639999803655c440@mail.gmail.com>
References: <ba5d9360903101553h3cf7c33ex639999803655c440@mail.gmail.com>
Date: Tue, 10 Mar 2009 17:55:49 -0500
Message-ID: <ba5d9360903101555o3d6f5932k9292a006328c7161@mail.gmail.com>
Subject: Re: TSEC/MDIO bug in recent kernels
From: Johns Daniel <johns.daniel@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(I did not get to complete the message!)

For those of you who are running into this error:
        24520:01 not found
        eth0: Could not attach to PHY
        IP-Config: Failed to open eth0
        IP-Config: Device `eth0' not found.

There is a bug in recent kernels. I found it in 2.6.28.7:
        linux/arch/powerpc/sysdev/fsl_soc.c:
for_each_compatible_node(np, "mdio", "gianfar");
should be:
        linux/arch/powerpc/sysdev/fsl_soc.c:
for_each_compatible_node(np, "mdio", "gianfar")

Note that the semicolon should not be there!

-- Johns
