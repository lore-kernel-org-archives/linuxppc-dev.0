Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A58A91A0D60
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 10:24:38 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 hbabu@us.ibm.com, nacc@linux.vnet.ibm.com
Subject: [PATCH 7/7] powerpc: enable CONFIG_NETFILTER_XT_MARK
Date: Tue, 20 Jan 2015 10:24:25 +1100
Message-Id: <1421709865-6368-7-git-send-email-anton@samba.org>
In-Reply-To: <1421709865-6368-1-git-send-email-anton@samba.org>
References: <1421709865-6368-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

docker requires CONFIG_NETFILTER_XT_MARK to be enabled.
Unfortunately that means turning on CONFIG_NETFILTER_ADVANCED.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/configs/pseries_defconfig    | 22 +++++++++++++++++++++-
 arch/powerpc/configs/pseries_le_defconfig | 22 +++++++++++++++++++++-
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 21c284e..f70c770 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -73,7 +73,27 @@ CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
 # CONFIG_IPV6 is not set
 CONFIG_NETFILTER=y
-# CONFIG_NETFILTER_ADVANCED is not set
+CONFIG_NF_CONNTRACK=m
+CONFIG_NF_CONNTRACK_FTP=m
+CONFIG_NF_CONNTRACK_IRC=m
+CONFIG_NF_CONNTRACK_SIP=m
+CONFIG_NF_CT_NETLINK=m
+CONFIG_NETFILTER_XT_MARK=m
+CONFIG_NETFILTER_XT_TARGET_LOG=m
+CONFIG_NETFILTER_XT_TARGET_NFLOG=m
+CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
+CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
+CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
+CONFIG_NETFILTER_XT_MATCH_POLICY=m
+CONFIG_NETFILTER_XT_MATCH_STATE=m
+CONFIG_NF_CONNTRACK_IPV4=m
+CONFIG_NF_LOG_ARP=m
+CONFIG_IP_NF_IPTABLES=m
+CONFIG_IP_NF_FILTER=m
+CONFIG_IP_NF_TARGET_REJECT=m
+CONFIG_IP_NF_NAT=m
+CONFIG_IP_NF_TARGET_MASQUERADE=m
+CONFIG_IP_NF_MANGLE=m
 CONFIG_BRIDGE=m
 CONFIG_VLAN_8021Q=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
diff --git a/arch/powerpc/configs/pseries_le_defconfig b/arch/powerpc/configs/pseries_le_defconfig
index 3805ade..e2b6080 100644
--- a/arch/powerpc/configs/pseries_le_defconfig
+++ b/arch/powerpc/configs/pseries_le_defconfig
@@ -74,7 +74,27 @@ CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
 # CONFIG_IPV6 is not set
 CONFIG_NETFILTER=y
-# CONFIG_NETFILTER_ADVANCED is not set
+CONFIG_NF_CONNTRACK=m
+CONFIG_NF_CONNTRACK_FTP=m
+CONFIG_NF_CONNTRACK_IRC=m
+CONFIG_NF_CONNTRACK_SIP=m
+CONFIG_NF_CT_NETLINK=m
+CONFIG_NETFILTER_XT_MARK=m
+CONFIG_NETFILTER_XT_TARGET_LOG=m
+CONFIG_NETFILTER_XT_TARGET_NFLOG=m
+CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
+CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
+CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
+CONFIG_NETFILTER_XT_MATCH_POLICY=m
+CONFIG_NETFILTER_XT_MATCH_STATE=m
+CONFIG_NF_CONNTRACK_IPV4=m
+CONFIG_NF_LOG_ARP=m
+CONFIG_IP_NF_IPTABLES=m
+CONFIG_IP_NF_FILTER=m
+CONFIG_IP_NF_TARGET_REJECT=m
+CONFIG_IP_NF_NAT=m
+CONFIG_IP_NF_TARGET_MASQUERADE=m
+CONFIG_IP_NF_MANGLE=m
 CONFIG_BRIDGE=m
 CONFIG_VLAN_8021Q=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-- 
2.1.0
