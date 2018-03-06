Return-Path: <ruscur@russell.cc>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwJ6m3gJqzDrV3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 11:48:32 +1100 (AEDT)
Message-ID: <1520297307.2077.1.camel@russell.cc>
Subject: Re: [PATCH 2/9] powerpc/eeh: Manage EEH_PE_RECOVERING inside
 eeh_handle_normal_event()
From: Russell Currey <ruscur@russell.cc>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 06 Mar 2018 11:48:27 +1100
In-Reply-To: <163b24ef504d753f4abf1510d9193962bbac32b7.1520294174.git.sam.bobroff@au1.ibm.com>
References: <cover.1520294174.git.sam.bobroff@au1.ibm.com>
 <163b24ef504d753f4abf1510d9193962bbac32b7.1520294174.git.sam.bobroff@au1.ibm.com>
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

On Tue, 2018-03-06 at 10:58 +1100, Sam Bobroff wrote:
> Currently the EEH_PE_RECOVERING flag for a PE is managed by both the
> caller and callee of eeh_handle_normal_event() (among other places
> not
> considered here). This is complicated by the fact that the PE may
> or may not have been invalidated by the call.
> 
> So move the callee's handling into eeh_handle_normal_event(), which
> clarifies it and allows the return type to be changed to void
> (because
> it no longer needs to indicate at the PE has been invalidated).
> 
> This should not change behaviour except in eeh_event_handler() where
> it was previously possible to cause eeh_pe_state_clear() to be called
> on an invalid PE, which is now avoided.
> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Reviewed-by: Russell Currey <ruscur@russell.cc>
