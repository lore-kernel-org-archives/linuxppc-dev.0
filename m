Return-Path: <linuxppc-dev+bounces-18743-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D94D2FEC0FC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 19:48:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgLFQ41Gkz2ynv;
	Wed, 25 Mar 2026 06:48:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774381722;
	cv=none; b=DY6OsIVq/J0V2mURF2Oc2vLI2PwlHoFYfIfB0Pygm+E8bqmF7Gp5odeG/GnMILC7gc+9rwoP2UrwOaVCQM/KfM1KgeAvg5xmgrUGpNMVw/K/i0jDn2UHXFavcPZFZVvYX2CoBEKE3240DQFscKF6m95uKhOe4/VJznERXUOLOmMXv5GazKY1X+EuBjgwX5T01t0exI9seBlkBhRTpUNyGr4H6d/QAsRKsfhPqXDQxjpZOfAjIyllRQ0MWVtRTVXtIpsM5swwS+7SjEQZ585lNb58RYRwTKEn1OvGyf+T9sntuO4WrfB3oEYMiqnlWJp7fAd5Sn/SRPcZqK3mi3Erhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774381722; c=relaxed/relaxed;
	bh=GGWlvb2n3V4HaO8XQjVf9hW7XhuAzhwdcuVxgB5Di8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RPQJuGLciJQfEMB6r9SNTy9aiTka46sdgGh4ZHOqFQcgbVRfftnCNw7ojwAft0Ij1ACOO3GjICHbrgsrbuXrG9LvWWAbEcPPco9ChVaTQw2q1fo0G+JIIHZgdXQebl4RLcNOU/I6TXY0ma8yXrBD+XfQcpyqUY22FOXDM8V7DUpsOroHETlsXSk8/YqJbmgrWgU2lTdGfaUQ+4RAWoomY2wLR5K2vF7vGlp1Yjzst7KOT8Vlq8fk+698DEE5ZFjIZnQoQuFJqXTLD9aGcmytVK6F0Wk8Pnfn8oJlUlq3LctQATxjEiQx2AkaLXIelMZMLxMdzo7iHiU1dcdxsrJrNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=XStmUXF8; dkim-atps=neutral; spf=pass (client-ip=212.227.15.18; helo=mout.gmx.net; envelope-from=w_armin@gmx.de; receiver=lists.ozlabs.org) smtp.mailfrom=gmx.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=XStmUXF8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmx.de (client-ip=212.227.15.18; helo=mout.gmx.net; envelope-from=w_armin@gmx.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 368 seconds by postgrey-1.37 at boromir; Wed, 25 Mar 2026 06:48:38 AEDT
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgLFL5tJgz2ynn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 06:48:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1774381712; x=1774986512; i=w_armin@gmx.de;
	bh=GGWlvb2n3V4HaO8XQjVf9hW7XhuAzhwdcuVxgB5Di8o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XStmUXF8K+IJI8C7LA4ocIU/wkbCX7yK0PkfEPyrfdtC4X4mcvUHRSne8PK0NKSO
	 xxzBa2T4JvPtpafaXtvkCyFD8YJU1pFPxJpTmt0Vx2ihFBq/0YmKyypJWsnC16AQe
	 g+jxFsP6x+icfVx9/Z9Wis+cLtZ5Qy1k70ZKF+B/KV0gb+1OQQ50IEHFxtUSNfqnH
	 9WquI/Ybniptw/XqmSj9uq7DMwZ5yJT9VyWuxaZmtbp34FsJQE7h/NDzoVoctN2ms
	 D3A3tCeIR+dOeXt1qEXiPHzCRYbqJCOsiLoR6O8uTAvOoQ8MF9kJFEqxnrhNV4EOV
	 51VNnEqIhJduwln8XQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJE6L-1vpN8Z0wQN-00N053; Tue, 24
 Mar 2026 20:42:04 +0100
Message-ID: <50ed0e80-c1f3-48da-81f6-9edd2b1c35e1@gmx.de>
Date: Tue, 24 Mar 2026 20:41:59 +0100
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] platform/wmi: use generic driver_override
 infrastructure
To: Danilo Krummrich <dakr@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Vineeth Vijayan <vneethv@linux.ibm.com>,
 Peter Oberparleiter <oberpar@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Harald Freudenberger <freude@linux.ibm.com>,
 Holger Dengler <dengler@linux.ibm.com>, Mark Brown <broonie@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Alex Williamson <alex@shazbot.org>,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
 linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-spi@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-arm-kernel@lists.infradead.org,
 Gui-Dong Han <hanguidong02@gmail.com>
References: <20260324005919.2408620-1-dakr@kernel.org>
 <20260324005919.2408620-7-dakr@kernel.org>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20260324005919.2408620-7-dakr@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KKKjGPofriNO2Y7ny8bzLW+ogpO7D8lGPS1ezTtV32qPriElMBO
 jvtg2QtMPBSSFpK+K9f9/W3IHaIUxxM1SjbuL+eF3f/6Z6WRzj/HQbWdJ/0smqYXW/iekvq
 A+6iz88zZSNd21TB/fuLIMalZH7T5q5DuSXS3//CqYIoGgOXkyuC7c9IHxbPHBnE7ZSgdkY
 FFp1rdFLmEZzrK9+h1giQ==
UI-OutboundReport: notjunk:1;M01:P0:d3EuPwV0q1k=;oepBLb9nUR78pAw3HQVMRrIKAdZ
 AAXdygB+dm1c49a/x1Od65WD9Yy4sOcKRmBuhF86VXkEECr6vfChZztH/cIU7/2+QJSWZYXD+
 ruLHg7TlRUX9ilW+orsGH04bQCqR02WRJWGxcXwSLvMXxhnZj4mjW7YGyu0lM1ol+jUwT5Rfu
 v/NBhQvd7EjbogSNcPdDR4N2VTmTLrdeg1uxBN7kp6VOkV2UNMwDyeF8lfN5LCwuR/FJTPjAi
 jdBm4xqvyxAtcHcGbdwEMPNxAsdYcSfjlV0JtrUOLGT/s3F04z8K96yjLZb5BEaf+sWWNvvpP
 Q8kTB8gmbl8bA5pMyA7unutI4O6NhWH7Az8wo1wDVXIVmjsBVdtGasBRKpPVtFgHeURxOJY8t
 FZW901rVw0pAlCtviIBA568bWJLHs5SzVRGPwaf00zYxyo/fcnr3Hnfe251Bk47b5ZmaRVEFj
 4ig4d+bO6qT1mHb/F7PPUAZFpJ7mSKXxm61hppOe3PTL+LqseHXe6Drwcf3G+P9/st6QshYcD
 wFYwoSCqdmY4J6CWhYk95Icw3T37nyxCEWZY27rvtyftaGr3YG5c5avZqCzcf/JWpFiyclV+U
 /Jx8Q+IZfOXXMUVl47A59Sjji1tLu+Qy8EBys8JoxhKh8WhVRqylJQEtAWt2Yn3WrwAQt5n/q
 f4a+2nwv0M5WbBm1roP2+o77K+MHObhIGOBynURMO67rKZz/ohMqoRhRWqKqlfl4fBRq5Qoso
 j/Gdw/XwEtXYt2BEkcZNTIX8D0d5fLfc1L95eTDk1BsQbaZeOJtllO3D6iTrow85KhhffYIQk
 tY97SqUbHZbS0u8jfakUOrJ6ztwpTGp8ms1suLEPWDVqhf1PAvhgUC1a9KyZhxSigHNmLJTW/
 +wkw9Udwv6GCPP/GbyxpDIUhCiBODCa50nCzvxojkkk1SDHsoocnxUEJWhyc+vg209YAb7Ogq
 OoJvmH0+Wq9EKRfiaOuAY+9lDEA/ICSZpz4vxGCzWwE5D2CFoItNoTw09ZGFNSpalJ4ttom6v
 YOAcLIor0X4z0t9VK79Bn3JCATJeXcbsD6lkBRNMVXG4jAIhdp4JhwBCR9ve9mtgFy3lYZ9iE
 YpCGfoYyCtYwSfYP9SR8vZ3MoSNCdmWOTDLbLo3MDwUg2cpkwvtiOZGrh9ZtUyRwhulfONs0r
 EEGQbWw+4Z762NHyT+qeGPx6swM5K/l2rwzZgGnH10iz23dCIqtJKMO+IRJNfqMcAKrqTWR6t
 2sUFWJyFNQqrAgbv7DQcaD8haiLc8hjCKHiSTF80ZRpixijU06/hL0eqbpwiLNDRqGFjg59rz
 vUgxaz79W9T0Hf+KqtngxHux5BOXhSdoLM0+OnoY1zfizUgML8YQOQsr5vpgldPpNdE+4jwuy
 /Ekb6sbuB2WKMAPwo30KZRn2hb/z8W3KPouwanQJpDGog9Y0j01Qf0phUgiUhI4xkTvHco9GP
 DXFwqtJjl/CHuBLmd5W86zHeXCE7Eg1FXTrujAiIvLv5tWt/MpDP0XuH4ki0QNJqenM/hCCaO
 FDJwmz/jPiae3Pb2jE+Tr95HV8LVdWDw92KMkz5dl4AmhOT19WLu37id5TkVizo3798YYC3EV
 CRS/DSNkU2LTro97ZC8ppgrgq8++zZl72SBGKS7FPKPu3ulIVvG1ADVapagksnAoqFWnEk5Qm
 055mpzXdKzj7eXkSLGUJmOBuqRJhjJaxvwCbY9F0GAsePUPT1gZQ7O1VWqjBu3sBDBB6EBra5
 TgfyHAisJezSHU2Uo6xEUS52qccuNNaX7mjyMD12OqFpq1LWHSeGijYX0/T/XIWeo5A8RMBMJ
 QtRLwxkp3LEpYG5UOVE8tuqd7gCZkEInFvt8SMCG/6fqITiBB/cS2K1Xfb6axNBIN2bcyg7Yt
 ASAvu2PcfU2/kqL+AvW7SQm0u5lFbpktwO8zkAVHOTxnnxh2wJcGcJkGIQOCtJxSzPxUU/Q2I
 ncFqmghQhwDo98SdVXbF7fYDhp9Meiud7AqyKxRLHXxsRittTL5ewt+mnGR/7+c1mBX5KA7Ll
 YxhkZsEx+GS+eQlv8KZ+wf5CxYBw85CEWWwVrXqUtxRfECH9y6aeGgSrdVceMtlWmZZ2kc3Hh
 8F7aSSXD1tDielEWE9z5cWZWwjl9j+0RM4oEzuTAF15CJzSBfMw8A5TiM573SVgitkjP9/cqX
 uHLVeMjFHavleYNx3UX2/ZguP5kC/AH21squr8CezFavWGT3M2BpsGgoowZd0mplJOgjkEPak
 h6/YfHYV3T5G5yyzpnYcdH7Mo86aFPCmtt9ToXOdTNlQp+Utgtw6eQ14gkY9Z3cGvY6HaAwFs
 Yxkocu6rxZFEq5uR85KooTqk0jr1eAwpinT+2pmaQ3d5FpdlSUg+DHb6xT1PT+D3Oc5JbFRtC
 uINLj2GXnxYf8Rl/M+rqopBwmVh7zJz/s61cnIg2A5SvkVjNOU13Z4Z8Vzp9jSmxh2fq8t+eA
 1jKCRbj5STMOIahPAEjAwkvK58S2JOo86JoQqutx0QvjJLEGpxUXrfZ04BOUs2pUgAq2n1NPJ
 Qco7008V3Vkteao/5zXEMTYYK2O1DJ8pjRlvClbK0QmyOOb5Q95K/XyTtHLyFCFxo4B4jWpy5
 tyu9DvuRCEkhD7i30aBNz/0seqQjkP3n1bCdCwjwp5TNgvHDEZIbLh+rGUXOM4B3ZsLN7u8f/
 rpXYlW5AcunHdIpdLAgcnhJ1jXCJfcrc6O8HaK0khkHk+CDy5nI14BgSSZj3+x7qNVLhyRyHG
 6YgKdCPkrQz5rICAx9d15Pec9CCJO3bhsh8P8IbeN7ilhhLceYMwn90ccVUpVL8g6c1Qdhg1j
 neXgW70hxlG8mCxSFS88M4UWMLJsPKED7kkcLN84qlZn+L+5oqxUSmdz4+oF7hYDgiFonkWSO
 Hm+6vpfpQZSfmyJJXeqkFj3AsVZQQH6Y/jtg59bcr+lEH+dwP7VXlqLPIGRvHtOfAdJljBx1c
 s27Wqcxn21Er/Qtx3QQkphB6z6QsrX+HdHHqenMfVYzwyLJwqik1ncE5eRLinvSUIG1aLl3O8
 a4I4RP+rmNN9IwrND2QOYDc9yxkFAO4Gc5PQWbDZV3pPul+B/bW3LBMF5dZ4GFQKqs6saLKvH
 M1YGY2X4S69/s8MKKtWy0GNZnAhot0/N1+QcMcgV0d9ts+FUKS4mMBVFbgB+2Xw+RsKYnC/cP
 QWPak1FJX+j+ewnrIrORHaJ/cDT4xlZDYIKwNq8DiH+P/NtbZvfM1raBHMzuGzqVcZZtGF+hP
 Lpp+eXfB6TYXLfIABePI1gjAE8Fab9nOaCUsuxzsI+t/0Z4KUDBPkKQexv+bGQ/8zgabyz6Bx
 PifgnTLpgQqwFcx0CS3HHG7MEiRKSzw8hp42iMStc1KQcJXeIOQscf/NlTP2Qq60fa6VdVYWp
 OsyOzdpRX3uFb6aZDzcWJqofHGn5z6g9zVbAXjfSz5ScPYZsjKiFI4kkxr9zX3x5A3uqPj8jO
 ks8bByudsMx2DA6xCNJB8yV1pa+KiDOVy1ICIzjrqPzTz9Y41vYiKbIAqWLilyeueNwRNgLi2
 mqWJViSe1GXCI19aLMDUD5qdXmzQOko/T85epjS26w+62MSnbzDue4rRiH+c7M2GwnmvB4fPJ
 jXVyncZDNgMmfYUZT+tXODH/gxhcbjIMMzCLgImpcuoEUsqNgmp6CrmJKWmuq8auhklQWxCj+
 uENEPrkEhjxpv9WibfRKGtIOQdOlnMxpKxrScu96i4sSCMA7KKbaiULt0mP5O8bo35my6BzXs
 BTf84rXi3c0PhhONve3VvMXZr5XiDnWAkIRxuc7nmgOb+aeRHrD75K+0ptQ/QUX/UMiGQoWZs
 cR1Ru80qE6AYICDpjkNILiiIG87cmVGR3S1eBSlwaXEB9Cd83/ESN3rByvfBwoEXd1JA24c/a
 ByWhsvaQoguU8dc/vkK5u9jgCMJEzuVPDIHSBrVdj2AlwNIUA6ENG+PMYTzqd0ilx4tLlt2J7
 jGo00TmFYKYDeh/POwbo09w3gJZ3T/1g2Y13I41hvX1KDql1B5X39Jiot6+suOvIfy/jkx/gB
 RM/JvhxUSbQJHuH8em/zL/XMQW4s94fdKtQA/hYyTjCuNtM1onbH8gwVzDkCEhk3/fx2ptxza
 J1l58Qg3VOpVhxXmfU0tUBNUvgbF+zbd61UKjF+6261b4ioAjD9hMGs9FXmZOWrjnnEAHDUAi
 q8nTvg1qGKLp9ANgVzgTBj4uMFj7JnK58UI7tLa7lIP+6qcmk+OGLij2qqJn/pYDlujiOJG3G
 k3ISczXkuAnbP+xZShpMuz7qxVNaA5Y7Aaaq0G4qNTh4tfvoLl5cHPHGJz8pTh51TdXumHbc+
 q917TZm8e0VbqwNl9VmT6TaTQpygecpD20Suffw0SFPZ2LCsDvWtIlpw9CItihrEdhHVaBYsY
 yqyz3rANxATTAaKnYgQFJz6qU5yn7qvy6xTR4oAzxsq1Yzb7o8Qj7cDbAhlj4RM1VqhDtwmv0
 hjtfrRFKo5LWJXkSAg4fTBRe7dCRr1amYtN2yLawDS19rPtJBPoRwDyPnRYikMAYmZZxu9fFV
 lVrtyKDoAa80qouDn7ADYxRXRShpGo7+9dYPJoaKYnokjEu+p3C+TfCfZVoUkifT8U8zuT/Ne
 xAdGvv/ZESy23aftSfg0+A4Eje82GyKy7pU+9ciBiKP3qtmhP6P/79WrWmiIM5a8tGwZygxA/
 nduxsAbcIKoaQ/inTQnJlO4uijd1l/ujfW7HEK9LPKX/N1y1j4rXNsqWAR6OqF44gb+pJWV98
 NVgPDS1FiI6DQ+laWhjVuwhY4WVeXT8+sjSNi6RA0doWcGIdkD7KyxVMFPL0tel6UBzbV5hgr
 U3CHt04r9BUPW/C0ynbjnodNuWDlUhFQLxUwa4lZT7B06mQ419ItMLewdgaGMcEQ6a+48MfS3
 AYyvvg+ipwfgjfpiT+5lmFcrpLhaStknITQnBoyDrmv3VtnfmocwpawPRg9Fq1euUk7i1gpv7
 h6DXjwF94hV2TpRBt0lcoekIfBbApAwnR4B+8uQQUsUG3cWakAfx9mK0CTl5VINSvSIqmvApH
 9rdFC1pIeAKtR4TMhFCL+Ow+r+0iuMoOAS5qRjDYxFpTvBKoMa5O2hivOgqCxYPchJcJvYffy
 v88RzMY4qvru92ntOeZN4bxuPdpslXNMfvURwC7G+sUX407qR9Edaqjq4X/praTxtylh9GgAM
 JNinVyVFYdOH0GOuiq1WVbE/qnrF9F6buSgguTH5bu0jltpkZQs5ehGgFEWZWjg6XPRhzXsfC
 rR+dkjFiQKo8+seL/csQgk25fHWbsFRHLoReXz1fTZLqDswiAjJJYvS0MiGo/eVI+MnPaaq9q
 v1o2nzxHm/9su+lpHsU4aNGCxLqlOuhmN3i9QeQ5ISkjHFvKPzeoC0P0wBbpOQ9oW9tZ2Mf8a
 Eq63KBPNXbE159fng81d+29Q==

Am 24.03.26 um 01:59 schrieb Danilo Krummrich:

> When a driver is probed through __driver_attach(), the bus' match()
> callback is called without the device lock held, thus accessing the
> driver_override field without a lock, which can cause a UAF.
>
> Fix this by using the driver-core driver_override infrastructure taking
> care of proper locking internally.
>
> Note that calling match() from __driver_attach() without the device lock
> held is intentional. [1]

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Link: https://lore.kernel.org/driver-core/DGRGTIRHA62X.3RY09D9SOK77P@ker=
nel.org/ [1]
> Reported-by: Gui-Dong Han <hanguidong02@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220789
> Fixes: 12046f8c77e0 ("platform/x86: wmi: Add driver_override support")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>   drivers/platform/wmi/core.c | 36 +++++-------------------------------
>   include/linux/wmi.h         |  4 ----
>   2 files changed, 5 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/platform/wmi/core.c b/drivers/platform/wmi/core.c
> index b8e6b9a421c6..750e3619724e 100644
> --- a/drivers/platform/wmi/core.c
> +++ b/drivers/platform/wmi/core.c
> @@ -842,39 +842,11 @@ static ssize_t expensive_show(struct device *dev,
>   }
>   static DEVICE_ATTR_RO(expensive);
>  =20
> -static ssize_t driver_override_show(struct device *dev, struct device_a=
ttribute *attr,
> -				    char *buf)
> -{
> -	struct wmi_device *wdev =3D to_wmi_device(dev);
> -	ssize_t ret;
> -
> -	device_lock(dev);
> -	ret =3D sysfs_emit(buf, "%s\n", wdev->driver_override);
> -	device_unlock(dev);
> -
> -	return ret;
> -}
> -
> -static ssize_t driver_override_store(struct device *dev, struct device_=
attribute *attr,
> -				     const char *buf, size_t count)
> -{
> -	struct wmi_device *wdev =3D to_wmi_device(dev);
> -	int ret;
> -
> -	ret =3D driver_set_override(dev, &wdev->driver_override, buf, count);
> -	if (ret < 0)
> -		return ret;
> -
> -	return count;
> -}
> -static DEVICE_ATTR_RW(driver_override);
> -
>   static struct attribute *wmi_attrs[] =3D {
>   	&dev_attr_modalias.attr,
>   	&dev_attr_guid.attr,
>   	&dev_attr_instance_count.attr,
>   	&dev_attr_expensive.attr,
> -	&dev_attr_driver_override.attr,
>   	NULL
>   };
>   ATTRIBUTE_GROUPS(wmi);
> @@ -943,7 +915,6 @@ static void wmi_dev_release(struct device *dev)
>   {
>   	struct wmi_block *wblock =3D dev_to_wblock(dev);
>  =20
> -	kfree(wblock->dev.driver_override);
>   	kfree(wblock);
>   }
>  =20
> @@ -952,10 +923,12 @@ static int wmi_dev_match(struct device *dev, const=
 struct device_driver *driver)
>   	const struct wmi_driver *wmi_driver =3D to_wmi_driver(driver);
>   	struct wmi_block *wblock =3D dev_to_wblock(dev);
>   	const struct wmi_device_id *id =3D wmi_driver->id_table;
> +	int ret;
>  =20
>   	/* When driver_override is set, only bind to the matching driver */
> -	if (wblock->dev.driver_override)
> -		return !strcmp(wblock->dev.driver_override, driver->name);
> +	ret =3D device_match_driver_override(dev, driver);
> +	if (ret >=3D 0)
> +		return ret;
>  =20
>   	if (id =3D=3D NULL)
>   		return 0;
> @@ -1076,6 +1049,7 @@ static struct class wmi_bus_class =3D {
>   static const struct bus_type wmi_bus_type =3D {
>   	.name =3D "wmi",
>   	.dev_groups =3D wmi_groups,
> +	.driver_override =3D true,
>   	.match =3D wmi_dev_match,
>   	.uevent =3D wmi_dev_uevent,
>   	.probe =3D wmi_dev_probe,
> diff --git a/include/linux/wmi.h b/include/linux/wmi.h
> index 75cb0c7cfe57..14fb644e1701 100644
> --- a/include/linux/wmi.h
> +++ b/include/linux/wmi.h
> @@ -18,16 +18,12 @@
>    * struct wmi_device - WMI device structure
>    * @dev: Device associated with this WMI device
>    * @setable: True for devices implementing the Set Control Method
> - * @driver_override: Driver name to force a match; do not set directly,
> - *		     because core frees it; use driver_set_override() to
> - *		     set or clear it.
>    *
>    * This represents WMI devices discovered by the WMI driver core.
>    */
>   struct wmi_device {
>   	struct device dev;
>   	bool setable;
> -	const char *driver_override;
>   };
>  =20
>   /**

