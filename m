Return-Path: <anton@samba.org>
Date: Tue, 17 Apr 2012 11:37:38 +1000
From: Anton Blanchard <anton@samba.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 00/21] EEH reorganization
Message-ID: <20120417113738.0f091da4@kryten>
In-Reply-To: <20120417012915.GA3806@shangw>
References: <1330409051-8941-1-git-send-email-shangw@linux.vnet.ibm.com>
 <20120413073931.0c36169b@kryten> <20120413120346.42e01402@kryten>
 <20120417012915.GA3806@shangw>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

> Thanks for the information. I'll try to reproduce the issue on
> Firebird-L today. By the way, it seems that "mstmread" is some
> user-level application accessing the config space while the problem
> happened?

The EEH error is caused by the Melanox firmware tools.

> It seems the crash was caused by something like WARN_ON(). I checked
> the function pointed by the backtrace (eeh_dn_check_failure) and I
> didn't find any place has called WARN_ON() staff. Maybe I missed
> something here.

No. I replaced that backtrace in eeh_dn_check_failure with a WARN_ON()
because the backtrace doesn't give us enough info. I'm submitting a
patch for that today.

Bottom line is mstmread has been causing an EEH error since at least
3.0, but in 3.4 we now oops instead of recovering. The signs all point
to the EEH rework in 3.4.

Anton
