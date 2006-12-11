Return-Path: <htejun@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0506.google.com [64.233.162.226])
	by ozlabs.org (Postfix) with ESMTP id 3768867C94
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 01:23:47 +1100 (EST)
Received: by nz-out-0102.google.com with SMTP id l1so833610nzf
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Dec 2006 06:23:44 -0800 (PST)
Message-ID: <457D69E7.9040708@gmail.com>
Date: Mon, 11 Dec 2006 23:23:35 +0900
From: Tejun Heo <htejun@gmail.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: [PATCH] libata: don't initialize sg in ata_exec_internal() if
	DMA_NONE
References: <200612081914.41810.arnd.bergmann@de.ibm.com>
	<20061211140258.GB18947@htj.dyndns.org>
In-Reply-To: <20061211140258.GB18947@htj.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tejun Heo wrote:
> I'll follow up with conversion to ata_do_simple_cmd().

The current situation is...

ata_exec_internal_sg()	: no user except for ata_exec_internal() yet
ata_exec_internal()	: one data transferring user. other are non-data
ata_do_simple_cmd()	: three users

So, adding another exec_internal variant doesn't look so hot.  It seems
we already have enough variants considering the small number of users.
I think it's best to leave it alone for now.

Thanks.

-- 
tejun
