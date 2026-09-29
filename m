Return-Path: <linuxppc-dev+bounces-28484-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E5ECA5FA5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 11:04:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvFgr3m6sz2yvy;
	Tue, 29 Sep 2026 21:04:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790679896;
	cv=none; b=oypbnDc73uyvcDHgrZAOkUTunu14QWJoqepDdGFPWuoT3BVv3EWNMxL74yucL77lhM9tXkQhUTn6ftjr7QMLMKDRwOCIgzjm6gyZRhQ0D3703gS3mY0NC0UfcDg1ApfnC0Ero4X1MMPZn62yrncm9XE7ffcyKaBmR7Nt2Zq0Ff4R08MgzQcK8cf/DHem3drccCvk9d7PI2hfxECeT7bzZHp3PCf5PS4leIwsWYlZ7E+iUlBae77LullQ2eCFoXedi3D3OG23l0Hofr7hzoloys3KUbTGAw13bAOjcVFyueKQ5MChwNhYolHtJAgrkW/iIGzYRSQPr9SExED3rlKBGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790679896; c=relaxed/relaxed;
	bh=mVB81BLw9e8pI0LFuv8F5wk+xRrUzasyGcCmn0hk9cM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m30kHKDVOxOzUOQwPvPNI+MOoq9yoNTN8BzwLuJvbJTW5iNGxy2oiGtUaQYmAsnCv25q6P4LQjQZMw/91u9yjwa0F7zjNJNJrgaPEKecSC8KhhFy6aduE0xwqOwVh4+dwGkX0WVUa8Zs04LwCpBjQwyaFYrbbkc+1LvzvRhK18AJPbv5OSBs3u+bqP5s3WSTZjBrw2eeTCVNpGfn4mG9OLbirL6rsYwRklIuY0xw8H0k3tXg8vJ+/bZH/sLuxoG/ATQfCcoJzPaMw3/iNAlft+RDauG1vKOCEtRModZIqUxSKrmQsBTJZTUaqII8M3nkmCPBCZdBsG13Ewds54XXUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MVCmcHle; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cEbC9SiA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=DAoCEjSJ; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=k9MjFREv; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MVCmcHle;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cEbC9SiA;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=DAoCEjSJ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=k9MjFREv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvFgp5cCzz2yft
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 21:04:54 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 075AD21D8D;
	Tue, 29 Sep 2026 11:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790679881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mVB81BLw9e8pI0LFuv8F5wk+xRrUzasyGcCmn0hk9cM=;
	b=MVCmcHle04lk0lCS+vBT/Yt+vdGGO30J5Cq60qa6qsKQyF41OarQC0gZ6DFfHWyEkXUxiV
	CSEPGiATFeCPwFeLUMThPi/0JPco2ETDwo0vYMZxG4V68MCpJWjYk+SxL5yddI5ZS9QGnR
	UTzyznQoAbzTObmIDCZxMCZ1zi4qgN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790679881;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mVB81BLw9e8pI0LFuv8F5wk+xRrUzasyGcCmn0hk9cM=;
	b=cEbC9SiADCwKmYIC9O1apChXl2Bh1kTywwyWrNypheqZc08gBlG+JWAw0CfDTyyEbIsPqg
	yZ7lmbiysTjJlDBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DAoCEjSJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=k9MjFREv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790679877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mVB81BLw9e8pI0LFuv8F5wk+xRrUzasyGcCmn0hk9cM=;
	b=DAoCEjSJZi3XHJQuPl4sC7NpdJKF08cXQV2gtnTVS4sQ3osQAiozBglaZLb3VIYq8EBW2q
	jsrOcFN3kwkOWb1bdausa7Zl++qp16NeyNszUtyej0ZAzZ3yFHiNN9dBm9ZKmcDxqaRBBr
	swBhNrKBu3V7MpMTts9FyYMUhCaxkfs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790679877;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mVB81BLw9e8pI0LFuv8F5wk+xRrUzasyGcCmn0hk9cM=;
	b=k9MjFREvLNHETRZXt0zkUsT+7iVyUczGr2yjb9kHRBteDsCDwQx92Y5iyiRAbW5aoEmGWH
	5rTInQwDrUsr2sDQ==
Date: Tue, 29 Sep 2026 13:04:35 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm-ppc@vger.kernel.org
Subject: Re: early boot crash in init_tracer_tracefs
Message-ID: <arubQ77S4mvvykaN@kunlun.suse.cz>
References: <arYskzbiaNzBR9MD@kunlun.suse.cz>
 <20260928111234.faec09f7-8d-amachhiw@linux.ibm.com>
 <20260929093245.00008c9b-10-amachhiw@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260929093245.00008c9b-10-amachhiw@linux.ibm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [4.05 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	R_MIXED_CHARSET(0.56)[subject];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.19)[-0.972];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	SPAMHAUS_XBL(0.00)[2a07:de40:b306:2000::2:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,kunlun.suse.cz:helo,kunlun.suse.cz:mid];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b306:2000::2:from];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spamd-Bar: ++++
X-Rspamd-Queue-Id: 075AD21D8D
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Tue, Sep 29, 2026 at 09:36:05AM +0530, Amit Machhiwal wrote:
> On 2026/09/28 11:43 AM, Amit Machhiwal wrote:
> > Hi Michal,
> > 
> > Thanks for the report.  We have been looking at the crash and have some findings
> > and follow-up questions.
> > 
> > On 2026/09/25 10:10 AM, Michal Suchánek wrote:
> > > Hello,
> > > 
> > > There appears to be a regression between
> 
> < snip >
> 
> > > 
> > > Linux 7.0.12
> > > https://github.com/openSUSE/kernel/tree/4c9922875554ec191166ba6c0145f12d8ff9d4fc
> > > https://github.com/openSUSE/kernel-source/blob/2ebf0bc/config/ppc64le/default
> 
> I have been trying to recreate the issue with this kernel and config but I
> haven't been able to.  The L2 KVM guest boots fine everytime.
> 
> In addition to the requested information, could you please also share your qemu
> cmdline/guest xml you used?

The XML of the VM is below. What other information do you require?

Thanks

Michal

<domain type='kvm'>
  <name>kwork2</name>
  <uuid>6b72d912-3243-48af-8cb2-b61f04b93ff2</uuid>
  <metadata>
    <libosinfo:libosinfo xmlns:libosinfo="http://libosinfo.org/xmlns/libvirt/domain/1.0">
      <libosinfo:os id="http://suse.com/sles/16"/>
    </libosinfo:libosinfo>
  </metadata>
  <memory unit='KiB'>260000000</memory>
  <currentMemory unit='KiB'>260000000</currentMemory>
  <vcpu placement='static'>120</vcpu>
  <os>
    <type arch='ppc64le' machine='pseries-10.0'>hvm</type>
    <boot dev='hd'/>
  </os>
  <cpu mode='custom' match='exact' check='none'>
    <model fallback='forbid'>POWER11</model>
  </cpu>
  <clock offset='utc'/>
  <on_poweroff>destroy</on_poweroff>
  <on_reboot>restart</on_reboot>
  <on_crash>destroy</on_crash>
  <devices>
    <emulator>/usr/bin/qemu-system-ppc64</emulator>
    <disk type='file' device='disk'>
      <driver name='qemu' type='qcow2'/>
      <source file='/scratch/libvirt/images/kwork2.qcow2'/>
      <blockio logical_block_size='4096' physical_block_size='4096'/>
      <target dev='vda' bus='virtio'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x05' function='0x0'/>
    </disk>
    <disk type='file' device='cdrom'>
      <driver name='qemu' type='raw'/>
      <target dev='sda' bus='scsi'/>
      <readonly/>
      <address type='drive' controller='0' bus='0' target='0' unit='0'/>
    </disk>
    <controller type='usb' index='0' model='qemu-xhci' ports='15'>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x0'/>
    </controller>
    <controller type='scsi' index='0' model='virtio-scsi'>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x03' function='0x0'/>
    </controller>
    <controller type='pci' index='0' model='pci-root'>
      <model name='spapr-pci-host-bridge'/>
      <target index='0'/>
    </controller>
    <controller type='virtio-serial' index='0'>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x04' function='0x0'/>
    </controller>
    <interface type='bridge'>
      <mac address='52:54:00:94:23:7a'/>
      <source bridge='bridge'/>
      <model type='virtio'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x01' function='0x0'/>
    </interface>
    <serial type='pty'>
      <target type='spapr-vio-serial' port='0'>
        <model name='spapr-vty'/>
      </target>
      <address type='spapr-vio' reg='0x30000000'/>
    </serial>
    <console type='pty'>
      <target type='serial' port='0'/>
      <address type='spapr-vio' reg='0x30000000'/>
    </console>
    <console type='pty'>
      <target type='virtio' port='1'/>
    </console>
    <channel type='unix'>
      <target type='virtio' name='org.qemu.guest_agent.0'/>
      <address type='virtio-serial' controller='0' bus='0' port='1'/>
    </channel>
    <audio id='1' type='none'/>
    <memballoon model='virtio'>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x06' function='0x0'/>
    </memballoon>
    <rng model='virtio'>
      <backend model='random'>/dev/urandom</backend>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x07' function='0x0'/>
    </rng>
    <panic model='pseries'/>
  </devices>
</domain>


