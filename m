Return-Path: <srs0=3kig=6r=intel.com=fengguang.wu@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x8T5L2JV1zDq60
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jul 2017 09:13:42 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3x8T5L1jCZz8sxs
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jul 2017 09:13:42 +1000 (AEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3x8T5K46vzz9sBR
 for <linuxppc-dev@ozlabs.org>; Sat, 15 Jul 2017 09:13:39 +1000 (AEST)
Date: Sat, 15 Jul 2017 07:01:23 +0800
From: kbuild test robot <lkp@intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: kbuild-all@01.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/3] powerpc/mm: Mark __init memory no-execute when
 STRICT_KERNEL_RWX=y
Message-ID: <201707150643.fR3sYXES%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="x+6KMIRAuhnl3hBn"
In-Reply-To: <1500015083-23511-3-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Michael,

[auto build test ERROR on powerpc/next]
[also build test ERROR on next-20170714]
[cannot apply to v4.12]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Michael-Ellerman/powerpc-mm-radix-Refactor-radix__mark_rodata_ro/20170715-043340
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-allnoconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   arch/powerpc/mm/mem.c: In function 'free_initmem':
>> arch/powerpc/mm/mem.c:413:2: error: implicit declaration of function 'mark_initmem_nx' [-Werror=implicit-function-declaration]
     mark_initmem_nx();
     ^~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors

vim +/mark_initmem_nx +413 arch/powerpc/mm/mem.c

   409	
   410	void free_initmem(void)
   411	{
   412		ppc_md.progress = ppc_printk_progress;
 > 413		mark_initmem_nx();
   414		free_initmem_default(POISON_FREE_INITMEM);
   415	}
   416	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--x+6KMIRAuhnl3hBn
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICItJaVkAAy5jb25maWcAjDxbc9s2s+/9FZz2PLQzp4mvucwZP0AgKKIiCQYAJdkvHEVm
Ek1syZ8kt8m/P7sgJfGyUL/MZGxjF7fFYu/gb7/8FrDX/eZ5sV8tF09PP4Ov1braLvbVY/Bl
9VT9XxCqIFM2EKG0bwA5Wa1ff7x92fxTbV+Wwc2by6s3F39ul9fBpNquq6eAb9ZfVl9fYYTV
Zv3Lb9CDqyyS4zLP+bubYLUL1pt9sKv2vzhgvt0sq91usw12ry8vm+0eWk8dypFSk2tTXl/d
/eyMVH64/fGjPVgX6IHdXHjab+h2cXVx0QYMFgaratre/fhx+gMRorxor5klVk4F94xmbFim
adEdoWkkNp+mpUkkF8YzXMymosyhqynyXGnb7h8pzUVp0pzcsa8dRw2V0iORJMSk09Aot8zm
b54X5QgJmIWSZZ1ttdGur0ayszimeVzm8b0pWRjq0pbvbgCDXJFDDVPmxWzwOmR1ndKU5aXO
QlihNWXK5neX788hyOzu8pJG4CrNmf33gTp49XjHjbjDMsIWeZkL7UjHtGDkpjMhwiOWSEfw
VyS1sSWPi2xC7D7TpdSfzN3t5dWhyVjGJ1Yz5IIjezSwuhl6RAkbmyE8UXwSinwI0DMj0nLO
4zEcBzD7WGlp4/SEMBaZ0BJYcybkOLa9I4mZcWcJZABaxUKLzAJBzaTDOm1OOYzHTZES+xZM
J/dlrmVm22OwDLpYmQpV2LvLDxf91WVTzVqLNjwGCqtU2jICANwpBQMK3Wcodt9cObj2Ie/f
1iIcjcvLd7e3F+SZHua2I3OfUQKCFSB63UztkUXOco1iiL4eoYhYkdiykCkbC2pUR3c5Ejpj
VqoM9maMHCWiv/yQ6xJRpsIvGQAlTaXyTdOwC5yxGBV4DGPBEuClHh2PaEWu1Ui0pGs+tgyW
ViZiKhJzd+Rl2OWBM6Wxd7++fVp9fvu8eXx9qnZv/6fI8My0SAQz4u2bpdNMvx76jgqZhMgL
pZjXo5uapZ1eGjst+IRbeX056aSRVhORlUAukJSn9ckMTkhkU9gHLgUY5u76uEiugbJOBEig
7q+/nmjXtJVWGEp0AYVYMhXawPF0+rUBwB6WIrxjyAmcrkjK8YNsLZZsPPBLrIxFst39+vt6
s67+aM1q7s1U5pzkgnqPqUiVvi+ZBRETk3hRzLIwoTmpMCKRI99WHIe4qwDrgO0nh5MCaQW2
w+fdz92+ej6d1OFaAbg0sZoNRdEBUnNV6zChPVQpk1m3zWnOsLQxSOdQZuOWnMiZNk5uDmdx
HDY9rbkvv1CkwvyZNQQwVXgZQmbFYbd29Vxtd9SG4wfUDFKFsiOBMoUQ6SO6A5OQGOQ0XB7j
dqDNwHIDFfTWLnbfgz0sKVisH4PdfrHfBYvlcvO63q/WX09rs5JPas3GuSoyW1PvONVUatsD
nxM5eBiOrCf0weo0LwIzJBLg3pcAa88Of4IIANpRd9DUyO3uptffgp4yOAq5WBwdVG6S4G1P
VUbMgShOsxsx5iMnydrDayEcilPO5BxOlIF1kV3Rt1NO6l/oqzvWqsgNDYsFnzilh5xglabn
r/UkCiI3Fk0HkbB7evXJBMTP1AlRHRL04bxUORy4fBB4CZHN4UfKMt5RVn00A79QJwpX0SZw
4lzkTvE5up7OuGaF9sApCEYJ0knTmx8Li6ZK2dxxGuneROYsBqhfOSfu2hFhAj3NfUoDa0vH
wxz0uY9AKZZR4VlOVFgxp52iXPk2KccZS6KQBLqdeWBO/nlgozw6T9kYtA7tIXQNklN7OJWw
9WZQmp542k4helaVc1l+KqSe0N1hSSOmteyyzGG3aLeHIjyxXG08wozlURO0Zrq8GLrNjbOd
V9svm+3zYr2sAvF3tQbxy0AQcxTAoCY67vdpeHLJ07SGlk6k+pjw4MhomtdMwigFbpJi1N6T
SdTI2x9MbSFQCJYabAVFny0cngWHAzQjK8EQkpHkzor1XA4VyaSnJdqkVzVGR5r8VaR5CcsR
NNs1JiqtOXFM54+CJwR3AmUjB2+dctcdrohg/RKJDyZrp0fPQga2dMIe9FA5MjOW93hIgoRG
nxMWZ3ugSd+mrlu1sDSgbkVLN+oJyJM55gCxUpOh6QLmsTM6GnOp11sL8C7hdGtntNlryXLZ
w3P+fS5rv4G6LzgQ1Y73txk8LNI+mdziTwc8cEYBJUtlaVgkwAbL0a3t4cwEmxw8C1g+igLR
R2FwnmAvl7VxeLDjiZUYwfFegSufdJxLhzEGtZYnxVhmHbHQaqYvKq+3j5wgOGhuH+8Rtlef
qYbmVg8jVWGzk1xwvIsnOICKBPgIOVckkTMDiPHFHC4L8JqzyXHdRIDAdXciARQ7RcdO3OZc
0GcYfzlMQnst0jC4do5BKfMkURlcS1j0jOmwNbECowx0oimALFk4aGfc1gxxOjQ4BjDIT+Ig
is5IGLfmKe7LUcwfJVPOzmHJwfPTM1qz+5APzqG/Ex6PsXDv7X81Rwu95o8+eu2CczX98/Ni
Vz0G32t197LdfFk9dTyL43iI3Uh6II1ztbrkOkgmlCmHGBNxms4sMimO0GKSho099qviVOxN
ZqBzYKwchHWRIVLXQ2zgKB4b+DkY2XempRW+zm1gt3c32sIs3Che6nTWiRODFn7wmLwY85lL
7jFFASh5/m8xI0SJp2fA4FKBZ3Vmfs/gY7Bq8zEbsFP+tNijsdRKNHQG5LH2x77TnN9eXvkz
Dgi/OpORyFNGu2ZuZuHzCRrgv9Hyg3fqT1cs9NPww/W5JMo7D/Bgv/rgLAXZBiKR9mLAzhwX
vXhXL6gJCpOhWvIuTUUu8In2RwreiPTMJXNJEz31AXDweg0xCJMzvcEAkNrjGiD3fri6/eiF
evkaY6h1DNo/cXFdxtYF9c8x4+XFOy/44/sLYCg/r+fv++BDvCeIttV/Xqv18mewWy4aQdzR
XiA1PlE95eNTFTxuV39XW2g6jofN/SG8oSontTBOYo546KzkifB4nIyOyEQmKYtEXt6+v/UF
5OGI6LM3MoX5ynHe9S3bPtnmBTOfHd8LQ2k+LzV+KC/JLCMArm4vOmrsoby+oJMI9Sj0MHcw
TD9WE2sMyVHpQxD7aW7BDMm6mYCmfaoSMAGZpkM5DRalVmUWpRZtuFakJYm40p1pGjTDtczp
+1+bPqqgoU3/VBpPnBrmQ4fA5/SDuwLaGjkN5C19w6TCpGwsktwXEJpJZRPKD3YcLDKXbGhi
5bGyaMYT5u6MJZMGqwcdjABOn5p26DgRc+GL1IOVW/Zp0B4+SpiFsZtpWmZFkogxGIZNEqyc
sqQQd8ccWtPthI8NwEehW2mZDpxVDJJ0DZdOc9N10O1gx2FIdFy0oGA5o1ao19Dll6YdLKNI
uXGpIEWegA+SWzc3CBhzd9OLe3BvhAE0nj4TfziX0G5wnBtmFboZnXM0VHbzkKxxTk2KDAuD
391cfHx3pEU7UTzpEISD05pxBmKA5o+UTj0/5ErRVsrDqKAF8IMzoxWZ0+ylBSOhNQbArS7A
KcAEoQsHdwsibiYO0vKw6uBCaWIZ2bvL6yPnuRqHlM3LBxBjSofgVbddPmdXYdDHWfseMoTO
iB71dn0QXXOwPUDD6LEAd7Kdm8upA0MHsollHBI5o9ddS1UcKIaeJCB2Ejh4lNi58fQsxbx1
+mDs8BKRjW1M5LvqRfTzuzILpRZIdS5JUqC+TEZk6QpvBWwwJFqnzUy38ZT7aodPBR49cLs3
vJoaejluHuGLaiNU19nlg5zsJ0g7uMYWdCgSgVJ5HBSA5dq/vJwZ2bkS7sTDarf6up4ttlWA
pOYb+MUcfZHaR4H2b5vdPlhu1vvt5ump2jZW066NItaPL5vVuuvCwLwiC51wHvo+0Gn3z2q/
/EaP3CXJDFWY5bH1qJCcc+YxflFxaeDy0BN7PwcDkwPZGzi1jiEMdsEe/8ZI9yO2uKR8O6SP
2aCwiV4Mk5Vh9WXx+uQaMDO5C8ATDBaH8ZbtmrXDrQzwoF531ePpeiZqhloEE0t3Fz/AFnP/
TtUlILVUFBlhAbrsQZu4COxQU2DUERKuyRHhoodgXYqpnvnYuWsbn4mXZ4JSOk43csyw/CWP
lQ9h9fdqWQVhl+1cPcRq2TQHamjkFnX64IxhFIqpTXNPSAv2nYUs8fmNYFm64SOp0xnTdRic
5sFoBgfFQs8iUDTMXL7xrC1YV6qEGsxA32Ycgphqj51YI2BpRzNMWZtpvnxGGd8D4abSKHrC
Y1EAaHSY1lP+18ZCwefC+G3R68qsYobadlREUXd3R8306Jigc76ppXKzoW0Fe1XUngm89AJ0
uKe4BaBoIGJ2uz1AU7lFgtDK6eRETm1dVQTtnXgX/N2HO/Hew4GB4ACAMD0TEkBwbrqXv27f
vBRr2o41YDnT/arLpmlA63S1W1LEBr5M73GBHoOSZdaXGRuj3uI3JNDKKHV8T0dfMp4oU2gs
R9QDBjvJ+BxcAVqEG1/ooq2dBuVOJ6PriiSSEMDFKRW3qyHlx2s+p+MdfPT+8mKw47qSpvqx
2AVyvdtvX59d6nT3DUT+Y7DfLtY7nCl4Wq2r4BGOaPWCvx5kIXvaV9tF4KKMX1bb539QUzxu
/lk/bRaPQV1+dsCV6331FKSSu2sVdiIghsuIaJ6qnGg9DRSjgeAD8sX2kZrGi795OVZgm/1i
XwXpYr34WiFFgt+5MukffVWA6zsOdzoKHtM8wefJGTMbgCwqDhJS+epQAO1MbZgMj/VRhoPZ
WF+oYUU5AjGU38lFY1vocXqiwvScupp8Qojg8vrjTfB7tNpWM/j/B8WeoKzETHpu2wEIdo+h
oykp43BdFLrrjjxDs0auX173w+2eYhVZXgzvUww84nhWvlUBdumIHoNFZP+doHOonawkSwV5
hTlcrcVyj0bnUNhZS+8ftJwvagagiQ+GqwJDClW8z7+QeSrLuhSRVrbx7Kw15Q3RsjxPJPd0
sxz+594N9Ql3hM1lktz3tlIf/xUnT91TBmZy2mUxQA2aCl0XrHYl4IqSGZTh8rCteU2ycTWL
XV/H5sHyabP83geI9eLzE/hI8T1eeSwsBOt1pvQEjWSXiQZbMc2xnmO/gdmqYP+tAmP+cYU2
6eKpHnX3pr08DNj2BMgRNrukVZaagURiU4+H6qBoMXjSFA6OEY6EZu54lnrCRTYWOmV0rGXG
wC8LFVXJYsyoXcNdS8PNerXcBWb1tAIfJxgtlt9fnhbrTswd+lHxWg52Yn+40RYU3HLzHOxe
quXqC7gDLB2x9mCjXvioNnLA81p9eV0vnXvVSCvC+Uyj0G+cIBADjAnYhmLuu2InrDjhoSd/
AzixfHdzdVnmqALJ07HcefH8mgQnLkNJFwsgzHhgOPVfLHvAyl6fG4w4E5HmHu8Gwal9d/3x
vResQ359dUnn3x3cmrk32oMIJr29oC8FG81vL4YGVbf3veG+OCmArSxZen19Oy+t4ezMGdn0
DIWm8w+3dPpGi3EB3oPHi0pFKNkh8jjg1PF28fINbwwh4diY9hSnYwa6kRYtoU4HczCeB7+z
18fVBoyv4/O3P/wP52AQNH4IheSwou3iuQo+v375Ato1HGrXiF4a1qskTpvDRaEI0t7gIOx4
kh6qyCi/sABppGKw+hPwABMxeAmG8MErImw85j9i3rHTClJMYY/atXNbRiRnufeCZtief/u5
wyeOQbL4SQe/3GAxLa4zlTv4nAtJBwUROmbhWAzZyk2PLybhfJ5w2p9OrdmfL9Wf3LeSIsml
14ApZvSppqnnPonU9DN+reAQvoHw1AnUtXlyJOEgKf9XhIwfSkgM167Qsw0iniBqi+8emPHE
TVJGhDfq0FTKRkVEZVjx6RTWz3kyx8U8lCb3FaAXHjnjcjI+03u62sIqqMPDblJ5BWwD7r+X
asIBy+1mt/myD2Lgje2f0+DrawXeHiGO6mgRytC898CrHVIbU28jjva/eVmtnQXWuy7cNZrN
65ZW1LWGzT0vM8FfccXeoOT+BSG1xdV5DJvSOXyRNgjA1R7fSSYjRevAOoPr0wG6et7sK/SK
qa1jDM9i1IEPO7487772SWkA8XfjXqEEag1+0Orlj5P51POsj/aV2fD+QKs36bzXfiJXkc2l
P/gCayg9ZELQg0e05yl6Jf2KjtMRzK1XzbvMNE17X/Df0gINPECvEMxnZK5Nf+Jx+2kbA/05
BumE+cBMt6v6ZI4Fwr7hnXEPpk5mtUp8jmKUDhkBdUj77dEghOtTMujf5HNWXn3IUnS+POmX
NhZoCvoKgSVeTlTGHIZ/RnRTuKcYKOWj4d5aLw6ewbvYd17un2jHhhKTrR+3m9VjR5BkoVaS
NnRDRt/ezBsUMJZux3KFBNyqoemEEbyO3dVKyJ2OmKomjMA1piI+hMccrcCbrZmha5iZ5tEP
47SzJ+YooACtrofwBcdcxSti9GR9eyKRcX2feysUIpMpKyNPGOYMTNaw0vs6KmJnen8qlKUD
bw7CLU0XzGtE5qb0ZJIirOPxwJo4fg9cn8pi+a1nOZtBmUR9B3bV6+PGfR6DOFbUDb7pHQyk
UxJqQZ8Epgl9GTJ8Q0Z7qwVYncmo9FoC9Q/gA88AWC/l+Kh+V0MjZZ63UiOZMd08to8GxEpW
n7cLMHi3m9f9al21ih1G0mJST5tOfupU2n6CE1L++M7E6ozncKCYB0AuJJ6iAEoiMg+0zvN3
yoyOBROd2CbXcHQcvBmawppfelIQ0M9eXoQy8oKlLUoqRwaw7sc/XENpRBJ5smoNAn4cZHT/
gehaQ+jsUIPC9Mzn7dUYvk9yAJQOSoD36nr6KtL4B889P3z44PDurDkZWl0799hDniPW/AGM
GnqAGgSK8y+CsOiRApu069vqJhTR/So106+zwaRrpsCF9MlwRHDuRg+hx5G1n/XupnOwSoce
koQhLZTxlU3/FefpqKKw462ZpjSOlkloQpAVUqeHHviMuH5M3y6T/bZYfq8LiF3ry3a13n93
bvHjcwV29KA2Cn4Y5TTd2D3YP1TB3R2/uZKCo4o1GAOMm0bCb55fQGb/6R6sg7Bfft+5CZd1
+5ZyLOssPtYN0iq6LjGaMZ0Baq4Fh6vjeeTaVG0W7nMtgqy+rb8ygqPdXV5c3bRNGy3zkpm0
9D4Bxkq4ut7J0GZQkYEExPBcOlIeUV6XsMyyszUPEcWhscCKC1PvrMP6ro8RrngSFU2KIWya
mXpINVlV5omgN6txtX7uPV5T7+jxB9EFAPXWTal3hqpLdA58moIfCHorrD6/fv3aK3V3dAIH
SGT9/GBvdcdPnfjJnStpVOaz3eph1OgvoI33/WizfJBOCdBhSP0D5MwM9VvJwvgsiBpr6kte
IbCpR8a6zfMLdXOhJRYlakbwSht8bslxrz6iKV+C8wqSzfL760t9vePF+mvnTqOtXOQwyvBl
ZGsKBIJlldWlVyTS7BOZkGmdL35vCDha0WK9Az/WU5/ugyvV98qeGlwfnMCPTPWFSo9eGDCZ
CJFTISGk14nVg993TWRo97/B8+u++vH/jVy7doMwDP2eLhm7dTDggJsEqIET0oWhJ0PXNh36
99XDhJeldGsqHWNsWUiy7r3CH9fbx263e9p6R0S4rTFwa9tAOgG1Uep8ZiUEh5/hWx93EaxL
6ZByrDxYj5oR0QBY1FYeMtY0j7BkD+aCfCUIUx4jj/h70kPB3lrssBEDlGkdtDBmIvFSpnZg
t6FN3gnjB+/lHmk0mteizM9JVAKsk3qb2bJ15rjNyJBSJe5+aYMlxpXAxoP4gABViKo93Aka
AMHkqsa/hpF3ishn3hqlozkcj8A/NHj5Gzeu92C9rzw4jlcrQxYYQRDVmXvsfVemE0vKGpx+
l+be1EVcJ7uUBg9SlEaA/zmcCFgOIQwGsyuV0D7Og9OGzgEAHntk8ijR4WbR2aiQmwjiv/b6
fVuZFfVqEvNEI92FkYooTSZmPQSryyaREKmPKB/DfN0H0FwK24s9rDxZiBzLPLTlxk8i6R1A
sRUK5qSwze+XcsgKT0IhkeRdJxT6SOoRfE80bMq7Svj8BU2EMoNM5CCC2EVcZwrASuYaAfv0
nVxHawzCA8U4jXKiQ54tyFDwt5Y/dUljShgZwipkNlohKe5UE6NiWQ2lROpDGtqzuONqcA23
SdvFDSwx/bmGEx5yMbGQpk6DcAYCQcsZ2Ths3RYvz7PUJkWYV41hFB1kzeLhSA9710Pspqqd
Ghes8UEtQOrASTIXIBBxcVW1PZhULyOUuYt5Y498JXT9+Pn6vP3G0s2DvQjFP5t23rUwJmS5
dDdB/AmqbjxRQ0MsjIevLkSPWBNLq/rC0RR2TSxrcSs1KRZB0AbqnGAvtwCA+4eMvznTq5hZ
7/hauiRKxOK1fEnbmaN73+Dv/gCK/qNG21gAAA==

--x+6KMIRAuhnl3hBn--
