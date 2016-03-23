Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qV9Qn579FzDq6y
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Mar 2016 11:28:33 +1100 (AEDT)
Received: from snap.ozlabs.ibm.com (static-82-10.transact.net.au
 [122.99.82.10]) by russell.cc (OpenSMTPD) with ESMTPSA id d097d608
 TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO
 for <linuxppc-dev@lists.ozlabs.org>;
 Wed, 23 Mar 2016 00:28:37 +0000 (UTC)
Message-ID: <1458692906.5945.2.camel@russell.cc>
Subject: Re: [PATCH] pseries/eeh: Handle RTAS delay requests in
 configure_bridge
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Date: Wed, 23 Mar 2016 11:28:26 +1100
In-Reply-To: <1458606895-24620-1-git-send-email-ruscur@russell.cc>
References: <1458606895-24620-1-git-send-email-ruscur@russell.cc>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-03-22 at 11:34 +1100, Russell Currey wrote:
> In the configure_pe and configure_bridge RTAS calls, the spec states
> that values of 9900-9905 can be returned, indicating that software
> should delay for 10^x (where x is the last digit, i.e. 990x)
> milliseconds and attempt the call again. Currently, the kernel doesn't
> know about this, and respecting it fixes some PCI failures when the
> hypervisor is busy.
> 
> The delay is capped at 0.2 seconds.
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>

Forgot to mention this patch should go to stable, 3.10+
