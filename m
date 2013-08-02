Return-Path: <mhcerri@linux.vnet.ibm.com>
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp02.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 262522C008C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Aug 2013 22:10:02 +1000 (EST)
Received: from /spool/local
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mhcerri@linux.vnet.ibm.com>;
 Fri, 2 Aug 2013 09:09:56 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 80F953520055
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Aug 2013 08:09:54 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay03.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r72C8WQQ25165828
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Aug 2013 09:08:32 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r72C9rVL010900
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Aug 2013 09:09:54 -0300
From: Marcelo Cerri <mhcerri@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH v2 0/2] drivers/crypto/nx: fixes when input data is too large
Date: Fri,  2 Aug 2013 09:09:50 -0300
Message-Id: <1375445392-16237-1-git-send-email-mhcerri@linux.vnet.ibm.com>
Cc: Marcelo Cerri <mhcerri@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series of patches fixes two bugs that are triggered when the input data is
too large. The first one is caused by the miscalculation of physical addresses
and the second one by some limits that the co-processor has to the input data.

Changes in v2:
        * Replace Signed-Off-By tags with Reviewed-By tags where it is
	  appropriate.

Marcelo Cerri (2):
  drivers/crypto/nx: fix physical addresses added to sg lists
  drivers/crypto/nx: fix limits to sg lists for SHA-2

 drivers/crypto/nx/nx-sha256.c | 108 +++++++++++++++++++++++-----------------
 drivers/crypto/nx/nx-sha512.c | 113 ++++++++++++++++++++++++------------------
 drivers/crypto/nx/nx.c        |  22 ++++++--
 3 files changed, 148 insertions(+), 95 deletions(-)

-- 
1.7.12
